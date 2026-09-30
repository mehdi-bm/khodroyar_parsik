import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val releaseKeys = Properties()
val releaseKeysFile = rootProject.file("key.properties")
if (releaseKeysFile.exists()) {
    releaseKeysFile.inputStream().use { releaseKeys.load(it) }
}
val hasReleaseKeys = listOf("storeFile", "storePassword", "keyAlias", "keyPassword")
    .all { !releaseKeys.getProperty(it).isNullOrBlank() }
val previewBuild = providers.gradleProperty("previewBuild").orNull == "true"

android {
    namespace = "com.parsik.caryar"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        // Required by flutter_local_notifications' Android implementation.
        isCoreLibraryDesugaringEnabled = true
    }

    defaultConfig {
        applicationId = "com.parsik.caryar"
        if (previewBuild) applicationIdSuffix = ".preview"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseKeys) {
            create("release") {
                storeFile = rootProject.file(releaseKeys.getProperty("storeFile"))
                storePassword = releaseKeys.getProperty("storePassword")
                keyAlias = releaseKeys.getProperty("keyAlias")
                keyPassword = releaseKeys.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (previewBuild) signingConfigs.getByName("debug")
                else if (hasReleaseKeys) signingConfigs.getByName("release") else null
        }
    }
}

// Never silently produce a store artifact using the development certificate.
gradle.taskGraph.whenReady {
    if (!previewBuild && !hasReleaseKeys && allTasks.any {
        it.project == project && (it.name.startsWith("assembleRelease") ||
            it.name.startsWith("bundleRelease") || it.name.startsWith("packageRelease"))
    }) {
        throw GradleException("Release signing is missing. Configure android/key.properties using key.properties.example.")
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
