<div align="center">

<img src="assets/aves-next-bird.svg" alt="Aves-Next" width="220">

# Aves-Next

**A community-maintained continuation of Aves with independent branding and distribution.**

[![Build APK](https://github.com/CookieCums/Aves-Next/actions/workflows/build-apk.yml/badge.svg?branch=develop)](https://github.com/CookieCums/Aves-Next/actions/workflows/build-apk.yml)
[![License](https://img.shields.io/badge/license-BSD--3--Clause-blue.svg)](LICENSE)

[Downloads](#downloads) · [Build from source](#build-from-source) · [Report a bug](https://github.com/CookieCums/Aves-Next/issues) · [Discussions](https://github.com/CookieCums/Aves-Next/discussions)

</div>

---

## About

Aves-Next is a community fork of [Aves](https://github.com/deckerst/aves), focused on continuing development under a separate project identity.

The current Android builds are distributed as **Libre** and **Izzy** variants. The project does **not** use Firebase or Google Play Services integration in these supported variants.

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
- [Donations](#donations)
- [License](#license)

## Downloads

APK builds are produced automatically by GitHub Actions for the `develop` branch.

| Variant | Description |
| --- | --- |
| **Libre** | Aves-Next build using the Libre service configuration |
| **Izzy** | Aves-Next build using the Izzy service configuration |

### Latest CI builds

Use the [Build APK workflow](https://github.com/CookieCums/Aves-Next/actions/workflows/build-apk.yml) and open the latest successful run to download the generated APK artifacts.

There is currently **no official Google Play release** for Aves-Next.

## Features

Aves-Next retains the core capabilities of the Aves codebase, including:

- Fast browsing of large photo and video collections
- Albums, tags, places, countries, and other collection views
- Image and video metadata inspection
- Search and filtering
- File operations and media management
- Support for common image and video formats
- Android-specific media and storage integration

Feature behavior may change as the fork develops.

## Build from source

### Prerequisites

- Flutter SDK supplied by the repository's `flutterw` wrapper
- Android SDK
- Java 21 for the current Android build configuration
- Git with submodule support

### Clone

```bash
git clone --recurse-submodules https://github.com/CookieCums/Aves-Next.git
cd Aves-Next
```

### Libre build

```bash
./flutterw pub get
./flutterw packages pub run build_runner build --delete-conflicting-outputs
./flutterw build apk --flavor libre --release --split-per-abi
```

### Izzy build

```bash
./flutterw pub get
./flutterw packages pub run build_runner build --delete-conflicting-outputs
./flutterw build apk --flavor izzy --release --split-per-abi
```

For the exact CI build procedure, see [`build-apk.yml`](.github/workflows/build-apk.yml).

## Release signing

Aves-Next supports release signing through a local `android/key.properties` file or environment variables. **Do not commit your keystore or passwords.**

A PKCS#12 keystore (`.p12` / `.pfx`) is supported explicitly.

Example `android/key.properties`:

```properties
storeFile=/absolute/path/to/aves-next-release.p12
storePassword=YOUR_STORE_PASSWORD
keyAlias=YOUR_KEY_ALIAS
keyPassword=YOUR_KEY_PASSWORD
storeType=pkcs12
```

A template is provided at [`android/key_template.properties`](android/key_template.properties).

For Android's signing guidance, see the [official Android app signing documentation](https://developer.android.com/studio/publish/app-signing).

### GitHub Actions signing

CI signing credentials should be supplied through GitHub Actions secrets and protected files. Never commit a private signing key, keystore password, or key password to the repository.

## Development

The project uses Flutter with a bundled Flutter wrapper and Android Gradle tooling.

Useful commands:

```bash
./flutterw pub get
./flutterw analyze
./flutterw test
```

For debugging, run the appropriate Flutter flavor from your development environment and inspect the generated build output before distributing an APK.

## Permissions

Aves-Next requests Android permissions according to the media-management features being used. Review the Android manifest and in-app permission prompts before changing permission behavior.

## Contributing

Contributions, bug reports, and project discussion are welcome.

- [Issues](https://github.com/CookieCums/Aves-Next/issues)
- [Discussions](https://github.com/CookieCums/Aves-Next/discussions)
- [GitHub Actions](https://github.com/CookieCums/Aves-Next/actions)

When submitting a change, keep unrelated work separate and verify the affected build or test path before opening a pull request.

## Donations

If Aves-Next is useful to you and you would like to support continued development, you can donate via UPI.

<div align="center">

### Support Aves-Next

<a href="upi://pay?pa=godzspooky%40okaxis&amp;pn=Spookie&amp;cu=INR&amp;aid=uGICAgMD7uemSCA">
  <img src="assets/upi-donation-qr.svg" alt="Aves-Next UPI donation QR code" width="280">
</a>

**[Pay via UPI](upi://pay?pa=godzspooky%40okaxis&amp;pn=Spookie&amp;cu=INR&amp;aid=uGICAgMD7uemSCA)**

**UPI ID:** `godzspooky@okaxis`

Tap the QR code or **Pay via UPI** on a phone with a UPI app installed. On Android clients that allow the `upi://` scheme, this opens the available UPI app chooser with the recipient pre-filled.

</div>

> **Note:** The QR asset encodes the same UPI payment address and payment parameters supplied with the donation QR. GitHub or a particular browser/app may restrict custom `upi://` links.

## License

Aves-Next remains licensed under the **BSD 3-Clause License**. See [`LICENSE`](LICENSE).

The original Aves project was developed by Thibault Deckers. Aves-Next is maintained independently.

---

<div align="center">

**Aves-Next · Community fork · `develop`**

</div>
