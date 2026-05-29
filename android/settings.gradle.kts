pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
    // PASSO 13 — Firebase. O plugin google-services lê o
    // google-services.json (criado pelo flutterfire configure) e injeta as
    // credenciais no APK. `apply false` aqui só registra a versão; quem
    // aplica de fato é o módulo :app.
    id("com.google.gms.google-services") version "4.4.2" apply false
}

include(":app")
