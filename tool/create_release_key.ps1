$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$androidDir = Join-Path $projectRoot 'android'
$keyDir = Join-Path $androidDir 'keystore'
$keyPath = Join-Path $keyDir 'caryar-release.jks'
$propertiesPath = Join-Path $androidDir 'key.properties'
if ((Test-Path -LiteralPath $keyPath) -or (Test-Path -LiteralPath $propertiesPath)) {
    throw 'An existing release key or configuration was found. It will not be overwritten.'
}
$keytool = 'C:/Program Files/Android/Android Studio/jbr/bin/keytool.exe'
if (!(Test-Path -LiteralPath $keytool)) { $keytool = (Get-Command keytool -ErrorAction Stop).Source }
New-Item -ItemType Directory -Path $keyDir -Force | Out-Null
$randomBytes = New-Object byte[] 32
$rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$rng.GetBytes($randomBytes)
$rng.Dispose()
$releasePassword = [Convert]::ToBase64String($randomBytes)
$env:CARYAR_KEYTOOL_PASSWORD = $releasePassword
try {
    & $keytool -genkeypair -keystore $keyPath -storetype JKS -alias caryar -keyalg RSA -keysize 3072 -validity 10000 -dname 'CN=Parsik, OU=Khodroyar, O=Parsik, C=IR' -storepass:env CARYAR_KEYTOOL_PASSWORD -keypass:env CARYAR_KEYTOOL_PASSWORD -noprompt
    if ($LASTEXITCODE -ne 0) { throw 'Key generation failed.' }
    $properties = "storeFile=keystore/caryar-release.jks`nstorePassword=$releasePassword`nkeyAlias=caryar`nkeyPassword=$releasePassword`n"
    [System.IO.File]::WriteAllText($propertiesPath, $properties, [System.Text.UTF8Encoding]::new($false))
    Write-Output 'Release key and local signing configuration created. Passwords were not logged.'
} finally {
    Remove-Item Env:CARYAR_KEYTOOL_PASSWORD -ErrorAction SilentlyContinue
    $releasePassword = $null
}
