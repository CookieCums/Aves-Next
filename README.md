<div align="center">

<img src="assets/aves-next-bird.svg" alt="Aves-Next" width="220">

# Aves-Next

**A community-maintained continuation of Aves with independent branding and distribution.**

[![Build APK](https://github.com/CookieCums/Aves-Next/actions/workflows/build-apk.yml/badge.svg?branch=develop)](https://github.com/CookieCums/Aves-Next/actions/workflows/build-apk.yml)
[![License](https://img.shields.io/badge/license-BSD--3--Clause-blue.svg)](LICENSE)

[Project site](https://cookiecums.github.io/Aves-Next/) · [Downloads](#downloads) · [Build from source](#build-from-source) · [Report a bug](https://github.com/CookieCums/Aves-Next/issues) · [Discussions](https://github.com/CookieCums/Aves-Next/discussions)

</div>

---

## About

Aves-Next is a community fork of [Aves](https://github.com/deckerst/aves), focused on continuing development under a separate project identity.

The current Android builds are distributed as **Libre** and **Izzy** variants. The supported variants do not use Firebase or Google Play Services integration.

> Aves-Next is an independent community fork. It is not an official release of the original Aves project.

## Contents

- [About](#about)
- [Downloads](#downloads)
- [Features](#features)
- [Build from source](#build-from-source)
- [Release signing](#release-signing)
- [Development](#development)
- [Permissions](#permissions)
- [Contributing](#contributing)
- [Support](#support)
- [License](#license)

## Downloads

Release APKs are produced by GitHub Actions for the `develop` branch.

| Variant | Application ID | ABIs |
| --- | --- | --- |
| **Libre** | `ai.avesnext.libre` | `armeabi-v7a`, `arm64-v8a`, `x86_64` |
| **Izzy** | `ai.avesnext` | `armeabi-v7a`, `arm64-v8a`, `x86_64` |

Use the [Build APK workflow](https://github.com/CookieCums/Aves-Next/actions/workflows/build-apk.yml) and open a successful run to download the generated artifacts.

There is currently **no official Google Play release** for Aves-Next.

## Features

Aves-Next retains the core capabilities of the Aves codebase, including:

- Fast browsing of large photo and video collections
- Albums, tags, places, countries, maps, search, and filtering
- Image and video metadata inspection
- File operations and media management
- Support for common and uncommon image/video formats, including motion photos, panoramas, 360° media, and GeoTIFF-related workflows
- Android integrations such as widgets, app shortcuts, screen saver handling, global search, media viewer/picker functionality, and Android TV support

Feature behavior may change as the fork develops.

## Build from source

### Prerequisites

- Git with submodule support
- The repository's bundled Flutter SDK via `flutterw`
- Android SDK
- Java 21 for the current Android build configuration

### Clone

```bash
git clone --recurse-submodules https://github.com/CookieCums/Aves-Next.git
cd Aves-Next
```

### Libre

```bash
./flutterw pub get
./flutterw gen-l10n
scripts/apply_flavor_libre.sh
./flutterw build apk -t lib/main_libre.dart --flavor libre --split-per-abi
```

### Izzy

```bash
./flutterw pub get
./flutterw gen-l10n
scripts/apply_flavor_izzy.sh
./flutterw build apk -t lib/main_izzy.dart --flavor izzy --split-per-abi
```

For the CI implementation, see [`build-apk.yml`](.github/workflows/build-apk.yml).

## Release signing

Aves-Next supports release signing through `android/key.properties` or environment variables. **Do not commit your keystore or passwords.**

A PKCS#12 keystore (`.p12` / `.pfx`) is supported explicitly.

Example:

```properties
storeFile=/absolute/path/to/aves-next-release.p12
storePassword=YOUR_STORE_PASSWORD
keyAlias=YOUR_KEY_ALIAS
keyPassword=YOUR_KEY_PASSWORD
storeType=pkcs12
```

A template is provided at [`android/key_template.properties`](android/key_template.properties).

See the [official Android app signing documentation](https://developer.android.com/studio/publish/app-signing).

### GitHub Actions signing

CI signing credentials should be supplied through GitHub Actions secrets and protected files. Never commit private signing keys or passwords.

## Development

The project uses Flutter with a bundled Flutter SDK and Android Gradle tooling. Useful commands include:

```bash
./flutterw pub get
./flutterw analyze
./flutterw test
```

Keep unrelated work separate and verify the affected build or test path before distributing an APK.

## Permissions

Aves-Next requests Android permissions according to the media-management features being used. Review the Android manifest and in-app permission prompts before changing permission behavior.

## Contributing

Contributions, bug reports, and project discussion are welcome.

- [Issues](https://github.com/CookieCums/Aves-Next/issues)
- [Discussions](https://github.com/CookieCums/Aves-Next/discussions)
- [GitHub Actions](https://github.com/CookieCums/Aves-Next/actions)

## Support

If Aves-Next is useful to you, support the project through the dedicated donation page. The QR code is intentionally kept **off this README** and is shown only on the support page.

<div align="center">

<a href="https://cookiecums.github.io/Aves-Next/support.html"><img src="docs/assets/support-badge.svg" alt="Support This Project" width="230"></a>

</div>

The support page contains the supplied UPI QR code and the `upi://` payment button.

## License

Aves-Next remains licensed under the **BSD 3-Clause License**. See [`LICENSE`](LICENSE).

The original Aves project was developed by Thibault Deckers. Aves-Next is maintained independently.

---

<div align="center">

**Aves-Next · Community fork · `develop`**

</div>
