# Checkpoint 1 — Aves-Next Project State

> **Checkpoint date:** 2026-09-04
>
> **Repository:** `CookieCums/Aves-Next`
>
> **Branch:** `develop`
>
> **Purpose of this file:** Preserve the verified project state reached during the Aves-Next fork/build/branding work so the project can be resumed without relying on conversational memory.
>
> **Evidence standard:** This document records facts verified from the repository, GitHub Actions, previously inspected files, and the recorded conversation history available for this checkpoint. Where the available evidence is incomplete, the document says **"Unknown / needs clarification"** rather than guessing.

---

# 1. Project Overview

## 1.1 What Aves-Next is

Aves-Next is a fork of **Aves**, an Android gallery and metadata explorer application built with Flutter. The current repository description states:

> Aves-Next is a little Aves fork for Android — a gallery and metadata explorer built with Flutter.

The upstream README-derived feature description in the fork says the application handles common and uncommon image/video formats, scans media to identify motion photos, panoramas/photo spheres, 360° videos, and GeoTIFF files, and emphasizes navigation from albums to photos/tags/maps. It also integrates with Android and Android TV features including widgets, app shortcuts, screen saver handling, global search handling, and media viewer/picker functionality.

### Purpose

- Preserve the core Aves gallery and metadata-exploration capabilities while maintaining a separate fork under `CookieCums/Aves-Next`.
- Provide an independently branded Android build pipeline for the fork.
- Establish Aves-Next branding and visual identity before adding future project-specific functionality.
- Keep the existing Aves functionality intact unless a change is explicitly part of the fork work.

### Target users

The repository evidence supports the following target users:

- Android users managing image/video collections.
- Users who need media metadata exploration, maps, tags, albums, and search/navigation.
- Android/Android TV users who benefit from widgets, shortcuts, screen saver, global search, viewing, and picking functionality.
- Users working with less-common media formats such as multi-page TIFF, SVG, AVI, panoramas, and GeoTIFF.

A narrower or new Aves-Next-specific target audience beyond the original Aves audience is **Unknown / needs clarification**.

### Core problem it solves

The verified project description indicates that the app solves media-library discovery, organization, viewing, navigation, and metadata exploration on Android. A separate Aves-Next-specific problem statement beyond this inherited Aves purpose is **Unknown / needs clarification**.

## 1.2 Tech stack

| Area | Current verified technology |
|---|---|
| Main language | Dart |
| UI/application framework | Flutter |
| Android build language/configuration | Kotlin Gradle DSL (`build.gradle.kts`) plus Android tooling |
| Android platform | Android |
| Flutter SDK | Bundled as the `.flutter` Git submodule; repository pins Flutter `3.47.0-0.3.pre` |
| Dart SDK | Flutter reports Dart `3.13.0 (build 3.13.0-282.3.beta)` in the verified CI run |
| Java/JDK | JDK 21; CI used Temurin 21.0.12+1 |
| Android compile SDK | 37 |
| Android package id | `deckers.thibault.aves` |
| Android flavors | `play`, `izzy`, `libre` |
| Build output | Split-per-ABI Android APKs |
| CI/CD | GitHub Actions |
| Dependency/package manager | Dart/Flutter `pub` via `./flutterw pub get` |
| Localization | Flutter generated localizations from ARB files; `flutter gen-l10n` |
| Maps/media/plugins | Multiple Flutter packages and local workspace plugins; see `pubspec.yaml` |
| Repository hosting | GitHub |
| Flutter submodule source | `https://github.com/flutter/flutter.git`, submodule path `.flutter`, branch configured as `main` |

The complete dependency graph is defined in `pubspec.yaml` and `pubspec.lock`. The project uses a Flutter workspace containing local plugins such as `aves_magnifier`, `aves_map`, `aves_model`, `aves_report`, `aves_screen_state`, `aves_services`, `aves_ui`, `aves_utils`, and video-related plugins.

## 1.3 Key architectural decisions

### Fork rather than rewrite

The project remains structurally based on Aves. The current work deliberately modifies the fork in-place rather than replacing the application architecture.

### Bundled Flutter SDK

The project intentionally keeps the Flutter SDK as the `.flutter` Git submodule and uses `./flutterw` to invoke the bundled SDK. This reduces dependence on whatever Flutter happens to be installed globally on a developer or runner.

### Flavor-specific Android builds

The Android project retains the existing store-oriented flavor model:

- `play` — Google Play
- `izzy` — IzzyOnDroid
- `libre` — F-Droid, with `.libre` application id suffix

The current CI checkpoint builds only the `libre` and `izzy` release flavors. A Play APK is not produced by the dedicated `build-apk.yml` workflow.

### Split-per-ABI APKs

Release builds use `--split-per-abi`, producing three ABIs per flavor:

- `armeabi-v7a`
- `arm64-v8a`
- `x86_64`

The Android Gradle script also assigns ABI-specific version-code overrides using the base version code multiplied by 100 plus an ABI code.

### Release signing is optional in CI

`android/app/build.gradle.kts` loads signing credentials from either `android/key.properties` or environment variables. In the verified CI build, signing was not configured and the build log explicitly reported:

```text
Load keystore props from system environment
Skip release signing as it is not configured
```

Therefore, the successful CI APKs prove that the project can compile release APKs without configured release signing, but they do not establish that production signing credentials are configured or that the APKs are ready for store publication.

### Branding changes were kept separate from planned AI work

The project plan recorded in the conversation explicitly separates phases. The immediate priority was: establish a reliable APK build pipeline, then perform branding cleanup, then consider future AI features. No AI functionality was added as part of this checkpoint.

### New master visual identity

The selected visual identity is the **"Sunset Swallow"** concept: a pale blue/lavender rounded-square background with translucent layered blue bird/wing geometry and a small white spark.

The original SVG used as the design source was:

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="100%" height="100%">
  <defs>
    <linearGradient id="bgGlass" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#E8ECFF"/>
      <stop offset="100%" stop-color="#C5D3FF"/>
    </linearGradient>
    <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="12" stdDeviation="16" flood-color="#4C609B" flood-opacity="0.12"/>
    </filter>
  </defs>

  <rect width="512" height="512" rx="115" fill="url(#bgGlass)"/>

  <circle cx="256" cy="256" r="130" fill="#FFFFFF" opacity="0.4" filter="url(#shadow)"/>

  <path d="M210,190 L120,110 C150,170 180,210 210,210 Z" fill="#7C8CF8" opacity="0.5"/>

  <path d="M170,290 C200,320 270,300 320,240 L410,210 L330,230 C300,190 240,190 200,230 Z" fill="#5B6BF5" filter="url(#shadow)"/>

  <path d="M220,220 L160,80 C210,130 250,180 270,220 Z" fill="#FFFFFF" opacity="0.75" filter="url(#shadow)"/>

  <circle cx="320" cy="230" r="6" fill="#FFFFFF"/>
</svg>
```

The Android and Flutter implementations are approximations of this design rather than exact SVG renderings. This is an explicit technical limitation of the current implementation and is discussed later in this checkpoint.

---

# 2. Current Status

## 2.1 What's working right now

### Repository / Git

- Repository: `CookieCums/Aves-Next`.
- Current branch: `develop`.
- Current branch head: `450a0c05cb52cccf7c7210f2a15639f74e043cd8`.
- Current head commit message: `Fix AppReference compatibility aliases`.
- The branch is unprotected according to the GitHub branch metadata observed at checkpoint time.
- The current tree is rooted at tree SHA `7f842cc0626880881d5499215dd07e5b2e0173c2`.

### APK build pipeline

The dedicated `.github/workflows/build-apk.yml` workflow is currently functional.

Verified successful workflow:

- Workflow: `Build APK`
- Run ID: `33809200716`
- Run number: `19`
- Event: `push`
- Branch: `develop`
- Head SHA: `450a0c05cb52cccf7c7210f2a15639f74e043cd8`
- Conclusion: `success`
- Job: `Build Android APKs`
- Job ID: `100826801001`

All workflow steps in the successful job completed successfully:

1. Set up job
2. Checkout repository and Flutter submodule
3. Set up JDK 21
4. Verify Flutter wrapper
5. Get Flutter packages
6. Generate app localizations
7. Prepare APK output directories
8. Build Libre release APKs
9. Build Izzy release APKs
10. Verify collected APKs
11. Upload APK artifacts

The job verified exactly six APK files: three Libre and three Izzy.

### Latest successful artifact

The successful run produced:

- Artifact ID: `9914477730`
- Artifact name: `aves-next-apks-450a0c05cb52cccf7c7210f2a15639f74e043cd8`
- Artifact size: `147049279` bytes
- Artifact digest: `sha256:beb75b09f4b31e7ef80e1b9a9e738884e944be1b15d510d811855090b95d50bf`
- Created: `2026-09-03T21:51:57Z`
- Expires: `2026-09-17T21:51:48Z`
- Artifact was not expired at checkpoint time.

The earlier successful run `33672431716` is **not** the current build artifact. It belongs to an earlier head SHA and produced artifact ID `9863454722`. That older artifact must not be treated as the current build.

### Build outputs confirmed by the successful workflow

The workflow verified these six file names:

```text
app-armeabi-v7a-libre-release.apk
app-arm64-v8a-libre-release.apk
app-x86_64-libre-release.apk
app-armeabi-v7a-izzy-release.apk
app-arm64-v8a-izzy-release.apk
app-x86_64-izzy-release.apk
```

The workflow's successful build mechanism therefore establishes a working CI compile-and-package path for the current repository state.

### App naming / branding

The main Android application label is now `Aves-Next` in `android/app/src/main/res/values/strings.xml`.

The branding work also changed:

- Libre flavor app name to `Aves-Next`.
- Debug app name from `Aves [Debug]` to `Aves-Next [Debug]`.
- About page app name to `Aves-Next`.
- About page GitHub URL to the fork.
- About page license link to the fork.
- Bug-report URL to the fork.
- Bug-report generated log filename prefix to `aves-next-logs-`.
- Bug-report system-info header from `Aves:` to `Aves-Next:`.

### New branding implementation

Current verified files include:

- `android/app/src/main/res/drawable/ic_launcher_foreground.xml` — new Sunset Swallow foreground approximation.
- `android/app/src/main/res/drawable/ic_launcher_mono.xml` — new simplified monochrome silhouette.
- `android/app/src/main/res/drawable/ic_notification.xml` — new simplified monochrome bird notification mark.
- `android/app/src/main/res/values/colors.xml` — updated launcher background/flavor colors.
- `lib/widgets/common/identity/aves_logo.dart` — Flutter `AvesLogo` painter changed to the new geometry.
- `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml` and `ic_launcher_round.xml` still reference the foreground/background/mono resource structure.

### Compatibility aliases

`AppReference` now defines both the new project names and legacy names:

```dart
static const projectGithub = 'https://github.com/CookieCums/Aves-Next';
static const projectFaq = '$projectGithub/wiki/FAQ';
// Backward-compatible names used throughout the app.
static const avesGithub = projectGithub;
static const avesFaq = projectFaq;
static const appName = 'Aves-Next';
```

This prevented the branding cleanup from breaking existing callers that still referenced `avesGithub` and `avesFaq`.

## 2.2 Partially working / in progress

### Branding fidelity

The selected Sunset Swallow identity is implemented in multiple vector/code locations, but it is **not yet a fully exact master-asset replacement across every Android icon representation**.

The main unresolved area is the legacy density-specific launcher PNG set. The current `mipmap-mdpi/ic_launcher.png` was inspected and still contains the old PNG content. The same legacy set was known from the conversation to include:

- `mipmap-mdpi/ic_launcher.png`
- `mipmap-mdpi/ic_launcher_round.png`
- `mipmap-hdpi/ic_launcher.png`
- `mipmap-hdpi/ic_launcher_round.png`
- `mipmap-xhdpi/ic_launcher.png`
- `mipmap-xhdpi/ic_launcher_round.png`
- `mipmap-xxhdpi/ic_launcher.png`
- `mipmap-xxhdpi/ic_launcher_round.png`
- `mipmap-xxxhdpi/ic_launcher.png`
- `mipmap-xxxhdpi/ic_launcher_round.png`

A local replacement PNG set was generated from the new SVG, but the corresponding multi-file Git Data API commit attempt failed. The repository state at this checkpoint has **not** been verified to contain those new PNGs. Therefore the legacy PNG replacement remains unfinished.

Generated local PNG sizes recorded during the work:

| Density | Dimensions | Local file size |
|---|---:|---:|
| mdpi | 48×48 | 1002 bytes |
| hdpi | 72×72 | 1470 bytes |
| xhdpi | 96×96 | 2015 bytes |
| xxhdpi | 144×144 | 2848 bytes |
| xxxhdpi | 192×192 | 3801 bytes |

The local generated files were stored under `/mnt/data/aves-next-png-assets/` during the conversation.

### Exact adaptive-icon appearance

The selected source SVG uses a diagonal background gradient and shadow filters. The current adaptive launcher uses a solid background color `#C5D3FF` and a vector foreground. Android VectorDrawable does not provide an exact one-to-one reproduction of the SVG's `feDropShadow` and gradient behavior in the current implementation. A future exact implementation should use a dedicated drawable background/gradient and keep the bird artwork in the foreground rather than attempting to put the entire rounded-square SVG into the foreground.

### Localization branding

The Flutter English localization file still contains:

```json
"appName": "Aves",
"welcomeMessage": "Welcome to Aves"
```

Localization changes were deliberately deferred. Other locale ARB/XML files have not been comprehensively renamed. This means not every user-visible localization string necessarily says `Aves-Next` yet.

### Broader Android branding audit

The `drawable-v26` and `drawable-v31` resource areas, splash branding, and every possible branding surface were not completely audited after the Sunset Swallow change. They therefore remain **Unknown / needs clarification** for full-fidelity branding coverage.

## 2.3 Broken or untested

### Not currently known to be broken

The latest build pipeline is passing.

### Explicitly untested or not fully verified

- Manual installation and launch of the latest artifact on a physical Android device: **Unknown / needs clarification**.
- Manual inspection of all six current APKs from artifact `9914477730`: **not recorded as completed in this checkpoint**.
- Visual confirmation that the new launcher icon appears correctly on every Android launcher shape/size: **Unknown / needs clarification**.
- Manual confirmation of the notification icon appearance on-device: **Unknown / needs clarification**.
- Full Play flavor release build from the dedicated build workflow: **not performed by `build-apk.yml`**.
- Store publication readiness/signing: **Unknown / needs clarification**.
- Complete localization branding pass: not done.
- Full functional regression testing of Aves core behavior after branding changes: **Unknown / needs clarification**.
- AI functionality: not started.

## 2.4 Version / branch / commit

Current verified application version from `pubspec.yaml`:

```text
version: 1.14.9+173
```

The Flutter environment declared by `pubspec.yaml` is:

```text
flutter: 3.47.0-0.3.pre
sdk: ">=3.12.0 <4.0.0"
```

Current branch and commit:

```text
branch: develop
commit: 450a0c05cb52cccf7c7210f2a15639f74e043cd8
message: Fix AppReference compatibility aliases
```

---

# 3. Methodology — How We Got Here

## 3.1 Initial project direction

The project began as an Aves fork under `CookieCums/Aves-Next`. The recorded project direction was intentionally phased:

1. Establish a reliable APK build pipeline first.
2. Clean up branding and identity.
3. Validate the APK.
4. Only after the APK/build baseline is stable, consider AI functionality.

This avoided mixing high-risk architectural/AI changes into the initial fork stabilization work.

## 3.2 Build pipeline establishment

A dedicated GitHub Actions workflow was introduced at:

```text
.github/workflows/build-apk.yml
```

The workflow was designed specifically to:

- Build from `develop`.
- Use the repository's bundled Flutter wrapper/submodule.
- Use JDK 21.
- Build Libre and Izzy release APKs.
- Split APKs per ABI.
- Verify that exactly six APKs exist.
- Upload the APKs as a workflow artifact.

The workflow's triggering was intentionally narrowed to relevant project paths rather than firing on arbitrary repository changes. Its current path filters are:

```text
.github/workflows/build-apk.yml
android/**
assets/**
lib/**
scripts/**
pubspec.yaml
pubspec.lock
flutterw
.gitmodules
```

It also supports manual `workflow_dispatch`.

The build workflow changes were committed as:

```text
99b776f0b201fe0038c7ad769029c49e6b662d7c
```

## 3.3 Baseline build verification

The original successful build was workflow run `33672431716`. It built the six expected APKs and produced artifact `9863454722`.

Recorded APK sizes from that earlier success were:

| APK | Size |
|---|---:|
| `app-armeabi-v7a-libre-release.apk` | ~50.7 MB |
| `app-arm64-v8a-libre-release.apk` | ~52.7 MB |
| `app-x86_64-libre-release.apk` | ~57.8 MB |
| `app-armeabi-v7a-izzy-release.apk` | ~24.8 MB |
| `app-arm64-v8a-izzy-release.apk` | ~24.8 MB |
| `app-x86_64-izzy-release.apk` | ~25.8 MB |

These exact sizes belong to that earlier artifact and should not be attributed to the latest artifact unless re-checked.

## 3.4 Branding cleanup

Branding cleanup then covered Android app labels, README links/branding, About page links and names, and bug-report references.

Key branding commits recorded in the work history:

```text
db81b11c56d452f5a007e852e4dda12f5bafad46
be3dad91e425c14f2eb9c47cc1d1dea7e1e45b35
5265a1b4526e60bd181fcd356c79cd15792f1ab6
85d3efbf3cfb4a5ea1e18c6bb7973c8eb2681056
96208181a5375b8f802d73af4369e8538400e22c
b5e7b0a51e31e4c26ee8a1abbac9945966eddf5d
```

The exact mapping of each SHA to the individual branding-file change is preserved in the conversational project history, but not all intermediate commit diffs were independently re-fetched for this checkpoint. Where the exact mapping is not directly re-verified here, it should be treated as historical evidence from the project conversation, not as a newly reconstructed Git fact.

## 3.5 New icon/identity selection

The new visual identity was selected from a design iteration called **Sunset Swallow**. The design uses:

- `#E8ECFF` → `#C5D3FF` diagonal background gradient in the source SVG.
- `#7C8CF8` translucent rear wing.
- `#5B6BF5` main body.
- translucent white upper wing.
- small white circular spark.
- rounded-square background.

Because not all target formats can represent the source SVG's effects exactly, the design was translated into:

- Android VectorDrawable geometry.
- Flutter `CustomPainter` geometry.
- monochrome silhouette geometry.
- notification icon geometry.
- locally generated PNGs for legacy density resources.

## 3.6 Failed build and compatibility pivot

The first build after the branding/icon edits failed in workflow run `33806285343`.

The failure was caused by `AppReference` compatibility breakage: existing code still referenced `AppReference.avesFaq` and `AppReference.avesGithub`, while the initial branding cleanup had renamed those constants.

The fix was to restore those old names as aliases to the new fork URLs:

```dart
static const avesGithub = projectGithub;
static const avesFaq = projectFaq;
```

This fix was committed as:

```text
450a0c05cb52cccf7c7210f2a15639f74e043cd8
```

The next `Build APK` run succeeded as run `33809200716`.

## 3.7 Verification of the corrected build

The successful run verified:

- bundled Flutter wrapper initialization,
- package installation,
- localization generation,
- Libre release build,
- Izzy release build,
- six APK outputs,
- artifact upload.

This established the current build checkpoint.

---

# 4. Environment Setup Instructions

## 4.1 Known prerequisites

The repository evidence establishes these requirements:

### Operating system

The exact local developer OS used in the conversation is **Unknown / needs clarification**. The verified CI environment was:

```text
Ubuntu 24.04.4 LTS
GitHub-hosted runner image: ubuntu-24.04
```

A clean-machine setup for local Android development should therefore be treated as requiring a supported desktop OS with Android/Flutter tooling; the exact supported local OS matrix is **Unknown / needs clarification**.

### Required source/development tools

- Git
- Java 21 JDK
- Android SDK/tooling
- Flutter SDK is supplied through the `.flutter` submodule and `flutterw`
- Android build tools/Gradle dependencies as resolved by the project
- An Android device or emulator for manual runtime testing

### Flutter/Dart versions

From the project files and successful CI run:

```text
Flutter: 3.47.0-0.3.pre
Dart: 3.13.0 (build 3.13.0-282.3.beta)
```

### Java

The CI workflow explicitly installs:

```text
Temurin JDK 21
Verified CI runtime: 21.0.12+1
```

### Android compile target

`android/app/build.gradle.kts` declares:

```text
compileSdk = 37
```

The NDK version is inherited from the Flutter toolchain (`flutter.ndkVersion`) rather than hard-coded in this file.

## 4.2 Clean-machine setup

The following is the safest sequence supported by the repository's current structure.

### Step 1 — Clone the repository

```bash
git clone https://github.com/CookieCums/Aves-Next.git
cd Aves-Next
git checkout develop
```

### Step 2 — Initialize submodules

```bash
git submodule update --init --recursive
```

This is required because `.gitmodules` defines the `.flutter` submodule.

### Step 3 — Verify the Flutter wrapper

```bash
./flutterw --version
```

The verified CI output was:

```text
Flutter 3.47.0-0.3.pre • channel main • https://github.com/flutter/flutter.git
Framework • revision 7c7929adb0 ...
Engine • ...
Tools • Dart 3.13.0 ... • DevTools 2.59.0
```

### Step 4 — Get packages

```bash
./flutterw pub get
```

### Step 5 — Generate localizations

```bash
./flutterw gen-l10n
```

### Step 6 — Configure signing for local release builds, if required

Create:

```text
android/key.properties
```

Use the repository template `android/key_template.properties` as the schema. The expected keys are:

```properties
storeFile=<KEYSTORE_PATH>
storePassword=<KEYSTORE_PASSWORD>
keyAlias=<KEY_ALIAS>
keyPassword=<KEY_PASSWORD>
googleApiKey=<GOOGLE_API_KEY>
```

Do not commit real credentials or API keys.

### Step 7 — Select a flavor/dependency configuration

The README says to update dependencies for the desired flavor using a script such as:

```bash
./scripts/apply_flavor_play.sh
```

The dedicated CI workflow uses:

```bash
scripts/apply_flavor_libre.sh
scripts/apply_flavor_izzy.sh
```

The exact clean-machine flavor dependency matrix is **Unknown / needs clarification** beyond the scripts present in the repository.

### Step 8 — Run the application

The README documents:

```bash
./flutterw run -t lib/main_play.dart --flavor play
```

### Step 9 — Build the same six APKs as CI

```bash
scripts/apply_flavor_libre.sh
./flutterw build apk -t lib/main_libre.dart --flavor libre --split-per-abi

scripts/apply_flavor_izzy.sh
./flutterw build apk -t lib/main_izzy.dart --flavor izzy --split-per-abi
```

The exact local prerequisites for the Google Play signing configuration and Play-specific flavor are **Unknown / needs clarification**.

## 4.3 Environment variables

The Android Gradle script supports these environment variables when `android/key.properties` is absent:

```text
AVES_STORE_FILE
AVES_STORE_PASSWORD
AVES_KEY_ALIAS
AVES_KEY_PASSWORD
AVES_GOOGLE_API_KEY
```

The equivalent property names in `key.properties` are:

```text
storeFile
storePassword
keyAlias
keyPassword
googleApiKey
```

No real secret values are stored in this checkpoint.

## 4.4 Known setup gotchas

### Flutter submodule/channel mismatch behavior

During CI startup, the `.flutter` submodule pointed at a specific commit while `.gitmodules` declared the `main` branch. The wrapper automatically reported and repaired the detached-channel tracking state:

```text
Fixing detached HEAD: '.flutter' submodule points to a specific commit 7c7929...
not channel 'main' (as defined in .gitmodules).
...
fatal: the requested upstream branch 'origin/main' does not exist
...
Fixed! Migrated to channel 'main' while staying at commit 7c7929...
```

This did not prevent the build, but it is a notable setup behavior.

### Release signing is optional for compilation

A missing signing configuration does not block the current CI APK compilation, because the Gradle script explicitly skips release signing when no release signing config exists.

### Localization output contains many untranslated messages

`gen-l10n` currently reports large counts of untranslated messages in many locales. This is not treated as a build failure.

### Dependency drift exists

The verified build reports many newer package versions that are incompatible with current dependency constraints. No dependency upgrade campaign has been performed as part of this checkpoint.

---

# 5. Commands Run

This section distinguishes **commands actually observed in the verified CI logs** from **commands documented for local setup**. This is necessary because the available conversation history does not preserve a complete shell transcript of every local development command.

## 5.1 Verified CI commands, in execution order

### 1. Flutter wrapper version

```bash
./flutterw --version
```

**Purpose:** Verify the repository-bundled Flutter SDK and wrapper.

**Observed result:** The wrapper initialized successfully and ultimately reported Flutter `3.47.0-0.3.pre` on `main`, Dart `3.13.0`, and DevTools `2.59.0`.

### 2. Package resolution

```bash
./flutterw pub get
```

**Purpose:** Resolve Flutter/Dart dependencies.

**Observed result:** `Got dependencies!`

### 3. Generate localizations

```bash
./flutterw gen-l10n
```

**Purpose:** Generate Flutter localization code.

**Observed result:** Successful generation, with many untranslated-message counts reported.

### 4. Prepare output directories

```bash
mkdir -p outputs/libre outputs/izzy
```

**Purpose:** Create directories where CI stores the flavor-specific APKs before artifact upload.

### 5. Apply Libre flavor

```bash
scripts/apply_flavor_libre.sh
```

**Purpose:** Apply the dependency/configuration set for the Libre flavor.

### 6. Build Libre release APKs

```bash
./flutterw build apk -t lib/main_libre.dart --flavor libre --split-per-abi
```

**Purpose:** Build release APKs for Libre/F-Droid, split by ABI.

**Observed successful outputs in the baseline run:** three Libre APKs were built.

### 7. Collect Libre APKs

```bash
cp build/app/outputs/flutter-apk/*-libre-release.apk outputs/libre/
```

**Purpose:** Copy generated Libre APKs into the workflow artifact staging directory.

### 8. Apply Izzy flavor

```bash
scripts/apply_flavor_izzy.sh
```

**Purpose:** Apply the dependency/configuration set for IzzyOnDroid.

### 9. Build Izzy release APKs

```bash
./flutterw build apk -t lib/main_izzy.dart --flavor izzy --split-per-abi
```

**Purpose:** Build release APKs for IzzyOnDroid, split by ABI.

**Observed successful outputs in the baseline run:** three Izzy APKs were built.

### 10. Collect Izzy APKs

```bash
cp build/app/outputs/flutter-apk/*-izzy-release.apk outputs/izzy/
```

### 11. Verify APK count

```bash
find outputs -type f -name '*.apk' -print
test "$(find outputs/libre -type f -name '*.apk' | wc -l)" -eq 3
test "$(find outputs/izzy -type f -name '*.apk' | wc -l)" -eq 3
test "$(find outputs -type f -name '*.apk' | wc -l)" -eq 6
```

**Purpose:** Ensure the workflow collected exactly six expected APKs.

**Observed result:** All tests passed in the successful build.

## 5.2 Repository/API inspection operations

The development work also used GitHub repository inspection operations to:

- inspect `develop` branch metadata,
- inspect commit `450a0c05cb52cccf7c7210f2a15639f74e043cd8`,
- inspect the workflow-run list,
- inspect workflow jobs,
- inspect workflow artifacts,
- inspect workflow logs,
- read the current contents of relevant source/config files.

These were API/tool operations rather than shell commands. The exact underlying API calls were not recorded as a user-facing terminal session, so a literal shell transcript for them is **Unknown / needs clarification**.

## 5.3 Local design asset generation commands

A local PNG conversion pipeline from the selected SVG was performed during the conversation using CairoSVG/Pillow. The exact command line invocation was not preserved in the available history.

**Exact command:** Unknown / needs clarification.

The known output set is documented in section 2.2.

## 5.4 Local visualizer generation

A self-contained HTML visualizer was generated at:

```text
/mnt/data/aves-next-icon-visualizer.html
```

It included previews for adaptive launcher composition, foreground, monochrome, background, legacy-density simulations, notification icon, functional shortcuts, stop icon, Flutter logo, monochrome behavior, color inventory, and a replacement checklist.

The exact generation command was not preserved in the available history.

**Exact command:** Unknown / needs clarification.

---

# 6. Issues Encountered

## Issue 1 — First post-branding build failed

### Exact workflow

```text
Build APK
Run ID: 33806285343
Run number: 18
Conclusion: failure
```

### Error evidence

The failure was traced to missing `AppReference` symbols:

```text
AppReference.avesFaq
AppReference.avesGithub
```

The available conversation history identifies these as references expected by existing code after the initial branding rename removed/changed them.

### Suspected cause at the time

The cause was a compatibility break introduced by renaming/removing existing `AppReference` constants during branding cleanup.

### Additional build environment observations

The CI log also reported:

```text
WARNING: Your app uses the following plugins that apply Kotlin Gradle Plugin (KGP): dynamic_color
Future versions of Flutter will fail to build if your app uses plugins that apply KGP.
```

This warning did not block the build and was not the cause of the failed run.

The log also showed many obsolete/newer dependency notices and many untranslated messages. These likewise did not cause the failure.

## Issue 2 — Attempted multi-file Git Data API icon commit failed

A multi-file commit intended to write the generated legacy PNGs was attempted during the icon update phase. The user reported:

```text
Commit failed
```

The available history does not preserve enough low-level API response detail to state exactly which API validation or payload element failed.

**Root error detail:** Unknown / needs clarification.

## Issue 3 — Flutter submodule tracking mismatch appeared during CI startup

The CI wrapper reported:

```text
fatal: the requested upstream branch 'origin/main' does not exist
```

It immediately followed this with a successful repair message:

```text
Fixed! Migrated to channel 'main' while staying at commit 7c7929adb0767c020659a422ae86df9ec0d5f82a.
'./flutterw upgrade' now works without problems!
```

Therefore this was a setup-state warning/repair rather than a persistent build blocker.

## Issue 4 — Branding coverage is incomplete

The current repository contains multiple Android icon resource styles. Some vector resources were updated, but the old density-specific launcher PNGs were still present when inspected. The generated replacement PNG upload was not verified after the failed commit attempt.

This is not a compile failure, but it means full visual branding replacement is incomplete.

## Issue 5 — Localization still contains old app name strings

The verified English ARB file still has:

```json
"appName": "Aves",
"welcomeMessage": "Welcome to Aves"
```

This means some user-visible localization strings still use the upstream name.

## Issue 6 — Exact SVG effects are not represented everywhere

The master design includes gradients and drop-shadow filters. The current Android vector and Flutter custom-painter representations approximate those effects and do not exactly reproduce the source SVG.

This is an implementation limitation, not a build error.

---

# 7. Fixes Applied

## Fix 1 — Restore AppReference compatibility aliases

### Patch

Added:

```dart
// Backward-compatible names used throughout the app.
static const avesGithub = projectGithub;
static const avesFaq = projectFaq;
```

### Commit

```text
450a0c05cb52cccf7c7210f2a15639f74e043cd8
Fix AppReference compatibility aliases
```

### Why it worked

The underlying problem was not the fork URL itself. The problem was API compatibility inside the Dart codebase: callers still referenced the old constant names. The aliases preserve those names while making their values point to the new Aves-Next fork URL.

The subsequent GitHub Actions run succeeded, establishing that this was the effective root fix for the build break.

## Fix 2 — Narrow APK workflow triggers

### Patch

`.github/workflows/build-apk.yml` was configured to run on `push` to `develop` only when relevant paths change, plus manual `workflow_dispatch`.

### Why it worked

This prevents unrelated repository changes from automatically triggering the APK build workflow while preserving rebuilds when application/build inputs change.

This did not eliminate all GitHub Actions runs for unrelated changes because `quality-check.yml` and other workflows still have their own triggers.

## Fix 3 — Update branding references

### Areas fixed

- Android application labels.
- README title/description/version/build references.
- README issue, discussions, changelog, setup/wiki references where changed.
- About page GitHub URL.
- About page FAQ URL.
- About page app name.
- About page license link.
- Bug-report issue URL.
- Bug-report system-info label.
- Bug-report log filename prefix.

### Why it worked

The repository-facing/user-facing branding references now point toward the fork in the audited files, while internal Dart identifiers were not broadly renamed.

## Fix 4 — Replace core vector/logo geometry with Sunset Swallow approximations

### Files changed

```text
android/app/src/main/res/drawable/ic_launcher_foreground.xml
android/app/src/main/res/drawable/ic_launcher_mono.xml
android/app/src/main/res/drawable/ic_notification.xml
android/app/src/main/res/values/colors.xml
lib/widgets/common/identity/aves_logo.dart
```

### Why it worked

The new geometry provides a single visual language across Android launcher, notification, and Flutter logo surfaces without requiring a complete architecture rewrite.

## Fixes attempted that did not fully succeed

### Legacy PNG multi-file repository commit

A generated replacement set for legacy density PNGs was prepared, but the repository commit attempt failed. Therefore that attempted fix cannot be marked as applied.

The exact failure mechanism is **Unknown / needs clarification**.

---

# 8. Testing / QA Status

## 8.1 Automated testing completed

### GitHub Actions build

The latest `Build APK` run is green and verified the full build pipeline through artifact upload.

### APK count validation

Automated checks confirmed:

```text
3 Libre APKs
3 Izzy APKs
6 APKs total
```

### Build environment validation

The workflow successfully validated:

- Flutter wrapper.
- package resolution.
- generated localizations.
- Android compilation.
- release packaging.
- artifact collection.

## 8.2 Manual testing completed

A complete on-device manual QA pass is **Unknown / needs clarification**.

A local HTML icon visualizer was created to inspect/reconstruct the icon resource set visually, but that does not substitute for testing the actual APK on Android hardware.

## 8.3 Test coverage

The project retains existing Flutter tests and test-driver infrastructure, but this checkpoint does not establish current coverage metrics.

`pubspec.yaml` shows dependencies on:

```text
flutter_test
flutter_driver
test
```

No current code coverage percentage was measured or recorded.

## 8.4 What has not been fully tested

- Full regression test suite after branding changes.
- Full runtime navigation/search/map/media tests.
- Android TV behavior.
- Media picker behavior.
- Widgets and screen-saver behavior.
- Notification appearance.
- Launcher icon rendering at every density and Android launcher mask.
- Locale-by-locale branding strings.
- Play flavor release packaging.
- Signed release installation/update behavior.
- Store deployment.
- Performance/battery behavior after fork modifications.

## 8.5 Known edge cases / failure scenarios

- Existing code can depend on upstream identifier names even when user-facing URLs/names are renamed. `AppReference` aliases were required to preserve compatibility.
- Legacy Android resource directories can bypass the modern adaptive-icon path on some device/API combinations.
- Vector drawables cannot necessarily reproduce complex SVG filters/gradients exactly.
- Missing signing credentials allow CI compilation but do not prove publish-ready artifacts.
- Flavor-specific dependencies can change the resolved dependency graph.
- Large untranslated-message counts indicate the localization layer is not fully aligned with the desired Aves-Next branding yet.

---

# 9. Roadmap

## 9.1 Immediate next steps

1. **Download and inspect artifact `9914477730` from run `33809200716`.**
   - Confirm the APK contents correspond to current commit `450a0c05...`.
   - Extract and inspect at least one Libre and one Izzy APK.
   - Verify package metadata/version/icon resources where feasible.

2. **Complete launcher PNG replacement.**
   - Replace the legacy density PNG set with the generated Sunset Swallow PNGs.
   - Verify the commit succeeds.
   - Re-run the build workflow.

3. **Audit remaining Android branding resources.**
   - Especially `drawable-v26`, `drawable-v31`, splash resources, and any other image assets.

4. **Perform the deferred localization branding pass.**
   - At minimum, audit `appName` and welcome strings.
   - Decide whether all localized values should say `Aves-Next` or whether some upstream wording is intentionally preserved.

5. **Manual Android installation test.**
   - Install a current APK on a real device or emulator.
   - Confirm launch, app name, launcher icon, notification icon, About page, and basic gallery operation.

## 9.2 Medium-term goals

- Finish end-to-end Aves-Next branding consistency.
- Establish repeatable local and CI release procedures.
- Decide whether store-specific workflows should remain or be rewritten for the fork.
- Audit other GitHub Actions workflows for unnecessary triggers or upstream-specific behavior.
- Review release/signing configuration for fork ownership and publication safety.
- Update project metadata/documentation to remove remaining upstream-only assumptions where desired.

## 9.3 Long-term / stretch goals

The conversation explicitly identified future AI-related work, but **no specific AI architecture or feature has been committed to this checkpoint**.

Potential future AI work discussed at a high level:

- local AI/image-model experimentation,
- image generation/model integration,
- future content-aware capabilities.

Exact product requirements, models, inference architecture, hardware targets, safety rules, and performance budgets are **Unknown / needs clarification**.

## 9.4 Future blockers / dependencies

- Exact release-signing setup.
- Finalized branding specification.
- Final decision on localization naming.
- Full audit of upstream-specific release workflows.
- Manual-device QA.
- Any future AI work will depend on clearly defined requirements and a decision about local versus remote inference.

---

# 10. Completed vs. Remaining Work (Checklist)

## Build / CI

### ✅ Fully completed

- [x] Dedicated GitHub Actions APK workflow created.
- [x] Workflow restricted to relevant application/build paths plus manual dispatch.
- [x] Flutter submodule checked out recursively in CI.
- [x] JDK 21 configured in CI.
- [x] `./flutterw --version` validation.
- [x] `./flutterw pub get` in CI.
- [x] `./flutterw gen-l10n` in CI.
- [x] Libre split-per-ABI release build.
- [x] Izzy split-per-ABI release build.
- [x] Automated six-APK count check.
- [x] Artifact upload.
- [x] Successful latest workflow run for current commit.

### 🟡 Partially completed

- [ ] Full release/publish workflow cleanup.
- [ ] Play flavor build in the dedicated APK workflow.
- [ ] Signed release validation.
- [ ] Manual artifact installation verification.

### ❌ Not started

- [ ] Final release/distribution strategy for Aves-Next.

## Branding / Identity

### ✅ Fully completed

- [x] Main Android app name changed to `Aves-Next`.
- [x] Libre/debug app labels updated.
- [x] About page fork URL updated.
- [x] About page app name updated.
- [x] Bug report URL updated.
- [x] Bug-report log prefix updated.
- [x] Core vector launcher foreground updated.
- [x] Monochrome launcher vector updated.
- [x] Notification icon updated.
- [x] Flutter `AvesLogo` geometry updated.
- [x] Launcher color resources updated.
- [x] Compatibility aliases restored.

### 🟡 Partially completed

- [ ] Legacy density PNGs.
- [ ] Exact SVG gradient/shadow fidelity.
- [ ] Full Android splash/visual resource audit.
- [ ] Full user-visible localization rename.

### ❌ Not started

- [ ] Complete automated search for every remaining upstream user-facing brand string.
- [ ] Final brand asset source file committed as a canonical project asset (the master SVG used in the conversation was not verified as committed to the repo).

## Documentation

### ✅ Fully completed

- [x] README renamed/reworked for Aves-Next in the audited sections.
- [x] Checkpoint-1-AvesNext.md created.

### 🟡 Partially completed

- [ ] Full documentation audit for upstream-only links and text.

## Localization

### 🟡 Partially completed

- [ ] English and other locale display-name strings still include upstream Aves wording.
- [ ] `gen-l10n` succeeds, but many locale messages remain untranslated.

### ❌ Not started

- [ ] Deliberate localization branding policy and migration.

## AI

### ❌ Not started

- [ ] AI feature requirements.
- [ ] Model selection.
- [ ] Inference architecture.
- [ ] UI/UX.
- [ ] Dataset/model training/integration.
- [ ] AI safety/permissions/privacy design.

---

# 11. Known Limitations / Technical Debt

## Branding technical debt

- Legacy PNG resources are not yet confirmed updated.
- The canonical master SVG is not confirmed as committed to the repository.
- The Android adaptive icon background is currently a solid color, not the source SVG's diagonal gradient.
- Flutter and Android icon implementations are hand-translated approximations rather than generated from one canonical source of truth.
- Full splash/alternate-resource branding audit remains incomplete.

## Upstream coupling

The fork still inherits many upstream package repositories, names, identifiers, and dependencies. `pubspec.yaml` still points to multiple `deckerst/*` repositories for dependencies.

This is not automatically wrong: the current project is intentionally a fork. However, it creates coupling that should be understood before claiming the project is fully independent.

## Application identity coupling

The Android application id remains:

```text
deckers.thibault.aves
```

This is inherited from Aves and was intentionally not broadly renamed in the recorded work. Any future package-id migration would be a major compatibility/release decision involving updates, permissions, store listings, and installed-app identity.

## Dependency drift

The verified CI logs reported many packages with newer versions that are incompatible with current constraints. No general dependency modernization was attempted during this checkpoint.

## Kotlin Gradle plugin warning

CI reported that `dynamic_color` applies the Kotlin Gradle Plugin in a way that future Flutter versions may reject.

This was not a current build failure, but it is technical debt that could become a future build blocker if Flutter's enforcement changes.

## Localization debt

The build succeeds despite substantial untranslated-message counts. The repository also still contains upstream Aves terminology in the English ARB and likely elsewhere.

## Release-signing debt

CI can currently produce unsigned release APKs because the workflow does not inject production signing credentials. This is suitable for compilation/artifact validation but is not equivalent to a production release pipeline.

## Action/workflow debt

The APK workflow was narrowed to relevant paths, but other repository workflows still have independent triggers. A complete "no Actions for arbitrary file changes" policy has not been implemented or verified.

## Security considerations

No new AI secrets or remote inference keys were added. The repository contains `android/app/google-services.json` and a template that expects a Google API key; the exact production security posture and key restrictions are **Unknown / needs clarification**.

---

# 12. Open Questions / Decisions Needed

## Branding

1. Should the legacy density-specific PNG icons be fully replaced now, or is relying on adaptive-vector resources sufficient for the supported Android API range?
2. Should a single canonical SVG be committed under a new path such as `assets/branding/` and treated as the source of truth?
3. Should the adaptive background reproduce the exact diagonal gradient from the master SVG?
4. Should the Flutter `AvesLogo` continue to render inside its existing circular frame, or should its outer treatment also be redesigned to match the new app icon exactly?

## Naming / identity

5. Should the Android package id remain `deckers.thibault.aves`, or should Aves-Next eventually adopt a new application id?
6. Should every user-visible localization string be changed from `Aves` to `Aves-Next`, including all locale files?
7. Which upstream attributions/links must remain for legal/ethical provenance, and which may be fork-specific?

## Release

8. Is the fork intended for Google Play publication, IzzyOnDroid/F-Droid distribution, sideloading, or a combination?
9. What signing keystore should be used for Aves-Next releases?
10. Should the existing upstream-oriented `release.yml` remain enabled, be adapted, or be replaced?
11. Should Play builds be included in the same artifact pipeline as Libre/Izzy?

## QA

12. What Android OS/API/device matrix is considered the minimum supported Aves-Next test matrix?
13. What manual smoke tests are required before a commit is considered release-ready?

## AI roadmap

14. What exact AI feature is the first target?
15. Is inference expected to be fully local, partially local, or remote?
16. What device hardware/RAM/GPU constraints must the future AI feature support?
17. What content/privacy constraints apply to AI processing of user media?

For all of the above, the present checkpoint does not select a final answer unless it is already evidenced elsewhere in the repository/history.

---

# 13. File/Folder Structure Reference

This is a **key-file reference**, not a complete repository manifest. The repository contains many additional files and plugins.

## Root

| Path | Purpose |
|---|---|
| `README.md` | Project overview, features, setup, contribution information, and badges. |
| `CHANGELOG.md` | Project release/change history. |
| `LICENSE` | BSD 3-Clause license; preserved from the upstream project. |
| `pubspec.yaml` | Flutter package metadata, version, SDK constraints, workspace members, dependencies, and project scripts/documentation. |
| `pubspec.lock` | Resolved Dart/Flutter dependency versions. |
| `analysis_options.yaml` | Dart analyzer configuration. |
| `.gitmodules` | Defines the bundled Flutter submodule. |
| `.flutter/` | Flutter SDK Git submodule. |
| `flutterw` | Wrapper used to invoke the repository-bundled Flutter SDK. |
| `.vscode/` | VS Code configuration. |
| `test_driver/` | Flutter driver/test infrastructure. |
| `assets/` | Application asset data; includes non-brand resources such as maps/country data and terms. |
| `scripts/` | Flavor-application and other project scripts. |

## GitHub configuration

| Path | Purpose |
|---|---|
| `.github/workflows/build-apk.yml` | Current dedicated APK CI workflow. |
| `.github/workflows/quality-check.yml` | Quality-check workflow; its trigger is independent of the APK workflow. |
| `.github/workflows/dependency-review.yml` | Dependency review workflow. |
| `.github/workflows/release.yml` | Release workflow inherited from the upstream project; full fork suitability has not been audited in this checkpoint. |
| `.github/workflows/scorecards.yml` | GitHub security/Scorecard-related workflow. |
| `.github/ISSUE_TEMPLATE/` | Bug/feature issue templates. |
| `.github/dependabot.yml` | Dependabot configuration. |

## Android

| Path | Purpose |
|---|---|
| `android/app/build.gradle.kts` | Android application configuration, package id, SDK versions, flavors, signing logic, build types, ABI/version code behavior. |
| `android/key_template.properties` | Non-secret template for release signing and Google API configuration. |
| `android/app/google-services.json` | Google services configuration file; exact intended fork usage requires further audit. |
| `android/app/src/main/res/values/strings.xml` | Main Android app label and Android-facing strings. |
| `android/app/src/main/res/values/colors.xml` | Launcher/background/flavor colors and window colors. |
| `android/app/src/main/res/drawable/ic_launcher_foreground.xml` | Sunset Swallow adaptive launcher foreground approximation. |
| `android/app/src/main/res/drawable/ic_launcher_mono.xml` | Monochrome launcher silhouette. |
| `android/app/src/main/res/drawable/ic_notification.xml` | Monochrome notification icon. |
| `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml` | Adaptive launcher icon definition. |
| `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml` | Adaptive round launcher icon definition. |
| `android/app/src/main/res/mipmap-*/` | Density-specific launcher assets, including legacy PNGs. |
| `android/app/src/libre/` | Libre-specific Android resources. |
| `android/app/src/libreDebug/` | Libre debug resources. |
| `android/app/src/debug/` | Debug resources. |

## Flutter application

| Path | Purpose |
|---|---|
| `lib/` | Main Dart application source. |
| `lib/main_play.dart` | Play flavor entry point. |
| `lib/main_libre.dart` | Libre flavor entry point. |
| `lib/main_izzy.dart` | Izzy flavor entry point. |
| `lib/widgets/about/app_ref.dart` | About-page identity and project links. |
| `lib/widgets/about/bug_report.dart` | Bug-report instructions, environment-info collection, and GitHub issue launch. |
| `lib/widgets/common/identity/aves_logo.dart` | Flutter-rendered Aves/Aves-Next logo widget and painter. |
| `lib/l10n/app_en.arb` | English localization source; still contains upstream `Aves` branding in key strings. |
| `lib/l10n/` | Other localization ARB resources. |

## Local plugins

The workspace declared in `pubspec.yaml` includes:

```text
plugins/aves_magnifier
plugins/aves_map
plugins/aves_model
plugins/aves_report
plugins/aves_report_crashlytics
plugins/aves_screen_state
plugins/aves_services
plugins/aves_services_google
plugins/aves_ui
plugins/aves_utils
plugins/aves_video
plugins/aves_video_exo
plugins/aves_video_mpv
```

These are part of the existing Aves architecture and were not rewritten as part of this checkpoint.

---

# 14. Miscellaneous Notes

## 14.1 Legal / attribution

The repository `LICENSE` remains the upstream BSD 3-Clause license with the original copyright holder information. The branding work deliberately did not alter the license.

Current file state recorded earlier:

```text
LICENSE: BSD 3-Clause
Copyright: 2020 Thibault Deckers
```

Whether future Aves-Next code additions require additional attribution or notice files is **Unknown / needs clarification**.

## 14.2 README areas intentionally preserved

The branding cleanup did not remove the original store/download and donation material merely because it came from the upstream project. The repository still contains references to Google Play, IzzyOnDroid, Obtainium, F-Droid, GitHub releases, PayPal, Liberapay, and Weblate.

Some of those links still point to upstream Aves resources. A complete policy decision on which external links should remain is still needed.

## 14.3 Weblate

The project currently uses Weblate for translations. The README's translation section still references the upstream Weblate project/engagement endpoint. Whether Aves-Next will continue sharing that translation project or move to a forked translation project is **Unknown / needs clarification**.

## 14.4 Upstream dependencies

`pubspec.yaml` currently references a mixture of standard pub packages and Git dependencies from upstream-related repositories, including several `deckerst/*` projects and a `media-kit` override.

This means Aves-Next is currently a functional fork, not an isolated dependency ecosystem.

## 14.5 App reference compatibility pattern

When changing public/static Dart constants in a mature app fork, retain compatibility aliases until all call sites are intentionally migrated. The `AppReference` failure demonstrates why.

## 14.6 Icon visualizer

A local self-contained visualizer was created at:

```text
/mnt/data/aves-next-icon-visualizer.html
```

It included previews of:

- adaptive launcher composition,
- foreground,
- monochrome,
- background,
- legacy density variants,
- notification icon,
- Collection shortcut,
- Map shortcut,
- Movie shortcut,
- Search shortcut,
- Stop icon,
- Flutter `AvesLogo`,
- monochrome Flutter behavior,
- color inventory,
- replacement checklist,
- search/filter.

The visualizer was a review aid. It did not itself modify repository files.

## 14.7 Functional shortcuts were intentionally not redesigned

The repository includes functional shortcut icons such as:

```text
drawable/ic_shortcut_collection.xml
drawable/ic_shortcut_map.xml
drawable/ic_shortcut_map_foreground.xml
drawable/ic_shortcut_movie.xml
drawable/ic_shortcut_search.xml
```

These were treated as functional UI symbols rather than part of the app-logo replacement and were not broadly redesigned during this checkpoint.

## 14.8 Notification icon behavior

The new notification icon intentionally omits the white spark and uses a simple black silhouette because notification icon rendering has stricter monochrome expectations than the launcher/brand artwork.

## 14.9 Current known GitHub Actions inventory

At checkpoint time, the repository had these workflows:

```text
build-apk.yml
quality-check.yml
dependency-review.yml
release.yml
scorecards.yml
```

Only `build-apk.yml` was the primary focus of the build stabilization work.

## 14.10 Current successful build environment details

The verified successful CI build used:

```text
Runner OS: Ubuntu 24.04.4 LTS
Runner image: ubuntu-24.04
Git: 2.55.0
Java: Temurin 21.0.12+1
Flutter: 3.47.0-0.3.pre
Dart: 3.13.0
DevTools: 2.59.0
Android compileSdk: 37
```

The workflow also reported installed Android NDK versions:

```text
27.3.13750724
28.2.13676358
29.0.14206865
```

These runner-installed values are not necessarily the only versions that can be used locally.

## 14.11 Build warnings preserved for future investigation

The successful CI build did not fail on the following warnings/conditions:

- many packages have newer versions incompatible with dependency constraints;
- one package was reported as discontinued during the Flutter SDK's own dependency setup output;
- `dynamic_color` still applies KGP and will need migration/upgrade before a future Flutter enforcement point;
- Java source/target value `8` obsolescence warnings were emitted by some Android compilation tasks;
- localization generation reported many untranslated messages.

These should be treated as technical-debt items, not as current build blockers.

## 14.12 Artifact references

### Current artifact

```text
Workflow run: 33809200716
Artifact ID: 9914477730
Artifact name: aves-next-apks-450a0c05cb52cccf7c7210f2a15639f74e043cd8
SHA-256: beb75b09f4b31e7ef80e1b9a9e738884e944be1b15d510d811855090b95d50bf
```

### Older successful artifact (do not use as current)

```text
Workflow run: 33672431716
Artifact ID: 9863454722
Head SHA: ecc01c9857464673c139e943e85224707b79925a
SHA-256: dfac51432de683f6450ae68e7b05c90188c65c0d8c7253bdd94a5eb036b07963
```

The distinction matters because the older artifact predates the final `AppReference` compatibility fix.

## 14.13 Historical build failure reference

```text
Workflow run: 33806285343
Head SHA: c41f4c1cbe4fefc901e90be79e78f8d1787c6f35
Result: failure
Primary cause: missing AppReference.avesFaq / AppReference.avesGithub compatibility names
```

## 14.14 Current checkpoint boundary

At this checkpoint:

- Build pipeline stabilization is effectively complete.
- Branding is materially updated but not fully normalized across every resource.
- Localization branding is still deferred.
- AI work has not started.
- Manual runtime QA remains the most important next validation step.

---

# Appendix A — Important current file contents

## `pubspec.yaml` version block

```yaml
name: aves
description: A visual media gallery and metadata explorer app.
repository: https://github.com/deckerst/aves
publish_to: none
version: 1.14.9+173

environment:
  flutter: 3.47.0-0.3.pre
  sdk: ">=3.12.0 <4.0.0"
```

Note: the Dart package name is still `aves`, and the `repository:` field in the fetched `pubspec.yaml` still points to upstream `https://github.com/deckerst/aves`. This is an important remaining fork-branding/metadata difference.

## `android/app/src/main/res/values/colors.xml`

```xml
<resources>
    <color name="ic_launcher_background">#C5D3FF</color>
    <color name="ic_shortcut_background">#FFFFFF</color>
    <color name="ic_shortcut_foreground">#455A64</color>
    <color name="ic_launcher_flavour">#5B6BF5</color>
    <color name="window_background_day">#FFFFFF</color>
    <color name="window_background_night">#262626</color>
</resources>
```

## `android/app/src/main/res/drawable/ic_launcher_foreground.xml`

```xml
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="100dp"
    android:height="100dp"
    android:viewportWidth="100"
    android:viewportHeight="100">

    <path
        android:fillColor="#5B6BF5"
        android:pathData="M33.2,56.64 C39.06,62.5 52.73,58.6 62.5,46.88 L80.08,40.63 L64.45,44.53 C58.59,38.68 46.88,38.68 39.06,46.49 Z" />
    <path
        android:fillColor="#7C8CF8"
        android:fillAlpha="0.5"
        android:pathData="M41.02,42.58 L23.44,26.95 C29.3,38.67 35.16,46.49 41.02,46.49 Z" />
    <path
        android:fillColor="#FFFFFF"
        android:fillAlpha="0.75"
        android:pathData="M45.88,44.44 L34.16,17.19 C43.93,26.95 51.74,36.72 55.65,44.44 Z" />
    <path
        android:fillColor="#FFFFFF"
        android:pathData="M62.5,45.0 A1.17,1.17 0,1 0,64.84,45.0 A1.17,1.17 0,1 0,62.5,45.0 Z" />
</vector>
```

## `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_launcher_background" />
    <foreground android:drawable="@drawable/ic_launcher_foreground" />
    <monochrome android:drawable="@drawable/ic_launcher_mono" />
</adaptive-icon>
```

## `android/key_template.properties`

```properties
storeFile=<KEYSTORE_PATH>
storePassword=<KEYSTORE_PASSWORD>
keyAlias=<KEY_ALIAS>
keyPassword=<KEY_PASSWORD>
googleApiKey=<GOOGLE_API_KEY>
```

## `AppReference` identity constants

```dart
static const projectGithub = 'https://github.com/CookieCums/Aves-Next';
static const projectFaq = '$projectGithub/wiki/FAQ';
static const avesGithub = projectGithub;
static const avesFaq = projectFaq;
static const appName = 'Aves-Next';
```

---

# Appendix B — Source-of-truth rule for future work

Unless explicitly replaced by a newer checkpoint, treat the GitHub repository state at:

```text
CookieCums/Aves-Next
branch: develop
commit: 450a0c05cb52cccf7c7210f2a15639f74e043cd8
```

as the current source of truth for the project state described here.

Do not infer completion from intent alone. For each future milestone, record:

1. the exact commit,
2. the exact workflow run if CI is involved,
3. the exact artifact if a build is involved,
4. what was actually tested,
5. what remains unknown.

That discipline is especially important for launcher assets, release signing, localization, and any future AI work.
