import 'dart:io';

void main() {
  final root = Directory.current;

  if (!File('${root.path}/pubspec.yaml').existsSync()) {
    stderr.writeln(
      'Error: Jalankan command dari root project Flutter.',
    );
    exitCode = 1;
    return;
  }

// root directory
  final lib = Directory('${root.path}/lib');

// create directory
  final directories = [
    'data/network',
    'data/models',
    'data/repository',
    'data/services',
    'providers',
  ];

  for (final path in directories) {
    final directory = Directory('${lib.path}/$path');
    directory.createSync(recursive: true);
    print('CREATE ${directory.path}');
  }

// Membuat file
  final files = <String, String>{
    'config/constants.dart': '''
class Constants {
}
''',
    'config/api_constants.dart': '''
class ApiConstants {
}
''',
    'config/app_styles.dart': '''
class AppStyles {
}
''',
    'config/routing.dart': '''
class Routing {
  static const splashPage = '/splash_page';
  static const loginPage = '/login_page';
  static const homePage = '/home_page';
}
''',
    'config/router.dart': '''
import 'package:flutter/material.dart';

import '../config/routing.dart';
import '../views/splash/splash_page.dart';
import '../views/auth/login_page.dart';
import '../views/home/home_page.dart';

class Router {
  static Map<String, Widget Function(BuildContext)> routingApp = {
    Routing.splashPage: (context) => const SplashPage(),
    Routing.loginPage: (context) => const LoginPage(),
    Routing.homePage: (context) => const HomePage(),
  }
}
''',
    'views/splash/splash_page.dart': '''
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''',
    'views/login/login_page.dart': '''
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''',
    'views/home/home_page.dart': '''
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''',
// APPBAR CUSTOM
    'utils/app_bar_custom.dart': '''
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_sharp),
      ),
      title: Text(title),
      centerTitle: false,
      actions: [
      ],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
''',
// DIALOG HELPERS
    'utils/dialog_helpers.dart': '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog {
  static Future<void> showLoadingDialog(BuildContext context, {String message = "Loading..."}) {
    return showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            // backgroundColor: Colors.white,
            // surfaceTintColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: 10.sp),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
''',
  };

  for (final entry in files.entries) {
    final file = File('${lib.path}/${entry.key}');

    if (file.existsSync()) {
      print('SKIP ${file.path} (sudah ada)');
      continue;
    }

    file.parent.createSync(recursive: true);
    file.writeAsStringSync(entry.value.trimLeft());
    print('CREATE ${file.path}');
  }

// UPDATE main.dart
  final mainFile = File('${lib.path}/main.dart');

  const mainTemplate = '''
import 'package:flutter/material.dart';

import 'config/routing.dart';
import 'config/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routing.splashPage,
      routes: AppRouter.routingApp,
    );
  }
}
''';

  if (!mainFile.existsSync()) {
    mainFile.writeAsStringSync(mainTemplate);
    print('CREATE lib/main.dart');
  } else {
    print('SKIP lib/main.dart (sudah ada)');
  }

  print('\\nFlutter structure generated successfully!');
}
