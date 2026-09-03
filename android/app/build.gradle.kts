import com.android.build.gradle.internal.api.ApkVariantOutputImpl
import java.util.Properties

plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.ksp)
    id("dev.flutter.flutter-gradle-plugin")
}

val packageName = "ai.avesnext"

val keystoreProperties = Properties()
val keystorePropertiesFile: File = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
} else {
    val env = System.getenv()
    fun getEnv(propKey: String, envKey: String) {
        if (envKey in env) keystoreProperties[propKey] = env[envKey]
    }
    getEnv("storeFile", "AVES_STORE_FILE")
    getEnv("storePassword", "AVES_STORE_PASSWORD")
    getEnv("keyAlias", "AVES_KEY_ALIAS")
    getEnv("keyPassword", "AVES_KEY_PASSWORD")
}

android {
    namespace = "deckers.thibault.aves"
    compileSdk = 37
    ndkVersion = flutter.ndkVersion

    compileOptions { isCoreLibraryDesugaringEnabled = true }

    kotlin {
        jvmToolchain {
            languageVersion.set(JavaLanguageVersion.of(21))
            vendor.set(JvmVendorSpec.ADOPTIUM)
        }
    }

    defaultConfig {
        applicationId = packageName
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        val storeFilePath = keystoreProperties["storeFile"] as String?
        if (storeFilePath != null) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(storeFilePath)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    flavorDimensions += "store"

    productFlavors {
        create("izzy") { dimension = "store" }
        create("libre") {
            dimension = "store"
            applicationIdSuffix = ".libre"
        }
    }

    buildFeatures { resValues = true }

    buildTypes {
        getByName("debug") { applicationIdSuffix = ".debug" }
        getByName("profile") { applicationIdSuffix = ".profile" }
        getByName("release") {
            if (signingConfigs.names.contains("release")) {
                signingConfig = signingConfigs.getByName("release")
            }
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            var useNdkAbiFilters = true
            if (rootProject.extra.has("split-per-abi")) {
                val splitPerAbi = rootProject.extra["split-per-abi"]
                if (splitPerAbi == "true" || splitPerAbi == true) useNdkAbiFilters = false
            }
            if (useNdkAbiFilters) {
                ndk { abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86_64") }
            }
        }

        val abiCodes = mapOf("armeabi-v7a" to 1, "arm64-v8a" to 2, "x86" to 3, "x86_64" to 4)

        applicationVariants.all {
            println("Application variant applicationId=$applicationId name=$name")
            resValue("string", "screen_saver_settings_activity", "${applicationId}/${packageName}.ScreenSaverSettingsActivity")
            resValue("string", "search_provider", "${applicationId}.search_provider")
            outputs.forEach { output ->
                val abi = output.filters.find { it.filterType == "ABI" }?.identifier
                val baseAbiVersionCode = abiCodes[abi]
                if (baseAbiVersionCode != null) {
                    val versionCodeOverride = versionCode * 100 + baseAbiVersionCode
                    (output as ApkVariantOutputImpl).versionCodeOverride = versionCodeOverride
                }
            }
        }
    }
}

androidComponents {
    onVariants(selector().withFlavor("store", "izzy")) { variant ->
        variant.packaging.jniLibs.useLegacyPackaging = true
    }
}

flutter { source = "../.." }

repositories {
    maven {
        url = uri("https://jitpack.io")
        content {
            includeGroup("com.github.deckerst")
            includeGroup("com.github.deckerst.mp4parser")
        }
    }
    maven {
        url = uri("https://s3.amazonaws.com/repo.commonsware.com")
        content { excludeGroupByRegex("com\\.github\\.deckerst.*") }
    }
}

dependencies {
    coreLibraryDesugaring(libs.android.desugarJdkLibs)
    implementation(libs.kotlinx.coroutines.android)
    implementation(libs.androidx.annotation)
    implementation(libs.androidx.appcompat)
    implementation(libs.androidx.ktx)
    implementation(libs.androidx.performance)
    implementation(libs.androidx.lifecycle)
    implementation(libs.androidx.media)
    implementation(libs.androidx.multidex)
    implementation(libs.androidx.security.crypto)
    implementation(libs.androidx.work.runtime)
    implementation(libs.commonsware.cwac)
    implementation(libs.metadata.extractor)
    implementation(libs.glide)
    implementation(libs.google.material)
    implementation(libs.slf4j)
    implementation(libs.deckerst.tiffbitmapfactory)
    implementation(libs.deckerst.androidsvg)
    implementation(libs.deckerst.mp4parser.isoparser)
    implementation(libs.deckerst.mp4parser.muxer)
    implementation(libs.deckerst.pixymeta)
    implementation(project(":exifinterface"))
    testImplementation(libs.junit)
    ksp(libs.glideKsp)
    compileOnly(rootProject.findProject(":streams_channel")!!)
}
