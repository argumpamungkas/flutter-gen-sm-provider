# Flutter Generator by Argumelar Pamungkas

A reusable Dart CLI tool to automatically generate a standardized folder structure and boilerplate files for Flutter projects.

## Features

- Automatically generate common Flutter project directories.
- Create starter pages for Splash, Login, and Home.
- Generate routing configuration.
- Create reusable utility files, including custom AppBar and dialog helpers.
- Skip existing files to prevent accidental overwrites.
- Designed to be reused across multiple Flutter projects.

## Generated Structure

The generator creates the following structure inside the `lib/` directory:

```text
lib/
├── config/
│   ├── constants.dart
│   ├── api_constants.dart
│   ├── styles.dart
│   ├── routing.dart
│   └── router.dart
├── data/
│   ├── network/
│   ├── models/
│   ├── repository/
│   └── services/
├── providers/
├── utils/
│   ├── app_bar_custom.dart
│   └── dialog_helpers.dart
└── views/
    ├── splash/
    │   └── splash_page.dart
    ├── login/
    │   └── login_page.dart
    └── home/
        └── home_page.dart
```

> **Note:** The generator creates the directory structure and starter files. Some directories, such as `data/network/` and `providers/`, may initially be empty.

## Requirements

- Flutter SDK
- Dart SDK
- Git

## Installation

Activate the generator directly from GitHub:

```bash
dart pub global activate --source git https://github.com/USERNAME/flutter-gen-sm-provider.git
```

Replace `USERNAME` with your GitHub username.

Make sure the package defines its executable in `pubspec.yaml`:

```yaml
executables:
  fluttergen-provider: fluttergen_provider
```

The package name in `pubspec.yaml` must be a valid Dart identifier. For example:

```yaml
name: flutter_gen_sm_provider
```

Ensure the Dart Pub cache executable directory is included in your system `PATH`.

## Usage

Navigate to the root directory of your Flutter project:

```bash
cd path/to/your_flutter_project
```

Run the generator:

```bash
fluttergen-provider
```

The generator will create the predefined directories and starter files inside `lib/`.

Example output:

```text
CREATE lib/config
CREATE lib/data/network
CREATE lib/views/splash/splash_page.dart

Flutter structure generated successfully!
```

Actual output depends on the directories and files defined in the generator.

## Safety

The generator checks for `pubspec.yaml` before proceeding.

Existing files are skipped rather than overwritten. This allows the generator to be run multiple times without replacing existing file contents.

**Important:** The current implementation checks for `pubspec.yaml`, which is also used by Dart packages. Make sure to run the generator from the root of a Flutter application.

## Development

Clone the repository:

```bash
git clone https://github.com/argumpamungkas/flutter-gen-sm-provider.git
cd flutter-gen-sm-provider
```

Get dependencies:

```bash
dart pub get
```

Run the generator locally:

```bash
dart run bin/fluttergen_provider.dart
```

Adjust the entry-point path if your repository uses a different filename.

## Updating

To update the globally activated generator after publishing changes to GitHub:

```bash
dart pub global deactivate flutter_gen_sm_provider
dart pub global activate --source git https://github.com/argumpamungkas/flutter-gen-sm-provider.git
```

Replace the package name and repository URL with your actual configuration.

## Roadmap

- [ ] Automatically update `lib/main.dart`.
- [ ] Support configurable feature names.
- [ ] Generate Provider, Model, and Repository templates.
- [ ] Add customizable templates.
- [ ] Add support for different architecture patterns.

## License

Copyright (c) 2026 Argumelar Pamungkas. All rights reserved.

This project is proprietary software. No license is granted for reuse, modification, redistribution, or commercial use without prior written permission from the copyright holder.pil

See the [LICENSE](LICENSE) file for details.
