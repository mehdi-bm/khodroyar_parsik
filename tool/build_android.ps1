param([switch]$Preview, [switch]$Bundle)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $projectRoot
$configPath = Join-Path $projectRoot '.secrets/ads.json'
if (!(Test-Path -LiteralPath $configPath)) {
    if ([string]::IsNullOrWhiteSpace($env:ADS_API_KEY) -or [string]::IsNullOrWhiteSpace($env:ADS_EXTERNAL_APP_API_KEY)) {
        throw 'Advertising configuration is required. Set ADS_API_KEY and ADS_EXTERNAL_APP_API_KEY locally, or create .secrets/ads.json.'
    }
    New-Item -ItemType Directory -Path (Split-Path $configPath) -Force | Out-Null
    $config = @{}
    foreach ($name in @('ADS_API_KEY', 'ADS_EXTERNAL_APP_API_KEY', 'ADS_BASE_URL', 'ADS_APP_NAME', 'ADS_PLATFORM', 'ADS_SECTION_CODE')) {
        $value = [Environment]::GetEnvironmentVariable($name)
        if (![string]::IsNullOrWhiteSpace($value)) { $config[$name] = $value }
    }
    [System.IO.File]::WriteAllText($configPath, ($config | ConvertTo-Json), [System.Text.UTF8Encoding]::new($false))
}
$configCheck = Get-Content -LiteralPath $configPath -Raw | ConvertFrom-Json
if ([string]::IsNullOrWhiteSpace($configCheck.ADS_API_KEY) -or [string]::IsNullOrWhiteSpace($configCheck.ADS_EXTERNAL_APP_API_KEY)) { throw 'Both advertising keys are required.' }
# The Windows Gradle wrapper echoes all arguments (including encoded API keys)
# when DEBUG is set. Disable that inherited behavior for this child build.
$previousDebug = $env:DEBUG
$env:DEBUG = $null
$env:NO_PROXY = 'localhost,127.0.0.1,::1'
try {
    $buildArgs = @('build', $(if ($Bundle) { 'appbundle' } else { 'apk' }), '--release', "--dart-define-from-file=$configPath")
    if ($Preview) { $buildArgs += '-PpreviewBuild=true' }
    & flutter @buildArgs
    if ($LASTEXITCODE -ne 0) { throw 'Android build failed.' }
} finally {
    $env:DEBUG = $previousDebug
}
