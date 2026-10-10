# Flutter Generator — Provider Architecture by Argumelar Pamungkas

A reusable Dart CLI tool that generates a predefined Flutter project structure, starter pages, routing configuration, utility classes, and common dependencies.

The goal is to reduce repetitive setup when starting a new Flutter project and maintain a consistent project structure across applications.

## Features

- Generate a standardized Flutter directory structure.
- Create starter pages for Splash, Login, and Home.
- Generate centralized route names and an `AppRouter` configuration.
- Create reusable utility classes for AppBar and loading dialogs.
- Generate configuration files for constants, API constants, and app styles.
- Automatically overwrite generated files, including `lib/main.dart`.
- Automatically install commonly used Flutter packages.
- Validate that the command is executed from a directory containing `pubspec.yaml`.

## Generated Project Structure

The generator creates the following structure inside `lib/`:

```text
lib/
├── config/
│   ├── constants.dart
│   ├── api_constants.dart
│   ├── app_styles.dart
│   └── router/
│       ├── routes.dart
│       └── app_router.dart
├── data/
│   ├── network/
│   ├── models/
│   ├── repository/
│   └── services/
├── providers/
├── utils/
│   ├── app_bar_custom.dart
│   └── dialog_helpers.dart
├── views/
│   ├── splash/
│   │   └── splash_page.dart
│   ├── auth/
│   │   └── login_page.dart
│   └── home/
│       └── home_page.dart
└── main.dart
```

Some directories are created empty and are intended for future implementation.

## Requirements

- Flutter SDK
- Dart SDK
- Git

Make sure Flutter and Dart are available from your terminal:

```bash
flutter --version
dart --version
```

## Installation

Activate the generator directly from its GitHub repository:

```bash
dart pub global activate --source git https://github.com/argumpamungkas/flutter-gen-sm-provider.git
```

Ensure your package's `pubspec.yaml` defines a valid Dart package name and executable:

```yaml
name: flutter_gen_sm_provider

executables:
  flutter_gen_provider: flutter_gen_provider
```

The package name uses underscores because Dart package names must follow Dart naming rules. The executable command can use hyphens.

Ensure the Dart Pub cache executable directory is included in your system `PATH`.

## Usage

Navigate to the root directory of the Flutter application you want to configure:

```bash
cd path/to/your_flutter_project
```

Run the generator:

```bash
flutter_gen_provider
```

The generator will:

1. Verify that `pubspec.yaml` exists.
2. Create the required directories under `lib/`.
3. Generate configuration files, routing, pages, and utilities.
4. Replace the contents of `lib/main.dart` with the generated template.
5. Replace the contents of other generated files.
6. Install the configured dependencies.
7. Display the execution result in the terminal.

## Automatically Installed Packages

The generator installs the following dependencies:

| Package              | Purpose                                   |
| -------------------- | ----------------------------------------- |
| `provider`           | State management                          |
| `flutter_screenutil` | Responsive sizing and layout              |
| `http`               | HTTP requests and API communication       |
| `shared_preferences` | Simple local key-value storage            |
| `get_it`             | Dependency injection and service location |

The dependencies are added using:

```bash
flutter pub add provider flutter_screenutil http shared_preferences get_it
```

## Important: Existing Files Are Overwritten

This generator currently overwrites the contents of these files whenever it runs:

- `lib/main.dart`
- All files listed in the generator's file template map.

**Back up your existing code before running the generator.** Existing implementations, imports, routes, and application configuration in those files will be replaced by the generated templates.

Files not listed in the generator's template map are not automatically overwritten by the file-generation loop.

## Routing

The generated application uses named routes.

Route names are defined in `lib/config/router/routes.dart`:

```dart
class Routes {
  static const splashPage = '/splash_page';
  static const loginPage = '/login_page';
  static const homePage = '/home_page';
}
```

The route mapping is defined in `lib/config/router/app_router.dart`:

```dart
class AppRouter {
  static Map<String, Widget Function(BuildContext)> routingApp = {
    Routes.splashPage: (context) => const SplashPage(),
    Routes.loginPage: (context) => const LoginPage(),
    Routes.homePage: (context) => const HomePage(),
  };
}
```

To add a new page, create the page widget, define its route name, and register it in `AppRouter.routingApp`.

## Development

Clone the repository:

```bash
git clone https://github.com/argumpamungkas/flutter-gen-sm-provider.git
cd flutter-gen-sm-provider
```

Install dependencies:

```bash
dart pub get
```

Run the generator directly using its Dart entry point:

```bash
dart run bin/flutter_gen_provider.dart
```

Update the command above if your entry-point filename or directory differs.

## Updating the Generator

After publishing changes to GitHub, update the globally activated version:

```bash
dart pub global deactivate flutter_gen_sm_provider
dart pub global activate --source git https://github.com/USERNAME/flutter-gen-sm-provider.git
```

## License

Copyright (c) 2026 Argumelar Pamungkas. All rights reserved.

This project is proprietary software. No license is granted for reuse, modification, redistribution, or commercial use without prior written permission from the copyright holder.

See the `LICENSE` file for details.

---

**Flutter Generator** — less repetitive setup, more time building features.
