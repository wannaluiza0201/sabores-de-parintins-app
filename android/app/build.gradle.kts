plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // PASSO 13 — Firebase. Aplica o google-services no módulo :app.
    // A versão é declarada em android/settings.gradle.kts.
    id("com.google.gms.google-services")
}

android {
    namespace = "br.com.sebrae.parintins.sabores_parintins_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        // PASSO 13 — flutter_local_notifications 18.x exige "core library
        // desugaring". Isso permite usar APIs Java 8+ (ex.: java.time)
        // em Android antigo, traduzindo no build time. Necessário também
        // o coreLibraryDesugaring no bloco dependencies abaixo.
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "br.com.sebrae.parintins.sabores_parintins_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// PASSO 13 — par do isCoreLibraryDesugaringEnabled acima. Sem esta
// dependência, o Gradle falha em runtime mesmo com a flag ativada.
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
