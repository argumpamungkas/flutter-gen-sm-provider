class GenFiles {
  Map<String, String> generate() {
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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static ThemeData themeData() {
    return ThemeData(
      // fontFamily: 'Rubik',
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade200,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontWeight: FontWeight.bold,
          fontSize: 10.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: TextStyle(
          color: Colors.grey.shade400,
          fontWeight: FontWeight.bold,
          fontSize: 10.sp,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade200,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontWeight: FontWeight.bold,
            fontSize: 10.sp,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
        ),
      ),
    );
  }
}
''',
// ROUTER
      'config/router/routes.dart': '''
class Routes {
  static const splashPage = '/splash_page';
  static const loginPage = '/login_page';
  static const homePage = '/home_page';
}
''',
      'config/router/app_router.dart': '''
import 'package:flutter/material.dart';

import '../../config/router/routes.dart';
import '../../views/splash/splash_page.dart';
import '../../views/auth/login_page.dart';
import '../../views/home/home_page.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext)> routingApp = {
    Routes.splashPage: (context) => const SplashPage(),
    Routes.loginPage: (context) => const LoginPage(),
    Routes.homePage: (context) => const HomePage(),
  };
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
      'views/auth/login_page.dart': '''
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
// INJECTION
      'config/injection.dart': '''
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

// digunakan unuk menginisiasi semua dependency injection yang digunakan di seluruh aplikasi
// secara sederhana, ketika ingin digunakan, tidak perlu menginisiasi lagi, cukup memanggilnya dengan di.get<T>() atau di<T>()

// contohnya :
// final _prefs = di<SharedPreferences>();
// ketika digunaknanya :
// _prefs.setString(Constant.userDetail, jsonEncode(_userDetail?.toJson()));
class Injection {
  Future<void> initialize() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      di.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

      // SERVICES

      // REPOSITORY
    } catch (e) {}
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
    return files;
  }

// update for main
  String updateMainTemplate() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'config/router/routes.dart';
import 'config/router/app_router.dart';
import 'config/app_styles.dart';
import 'config/injection.dart';

void main() async {

  // dependency injection
  await Injection().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // menggunakan library screenutilinit agar tampilan mengikuti ukuran device
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MultiProvider(
        providers: [
          // Create Provider
          // Semua Provider yang diinisiasi pada main/MyApp
          // maka provider tersebut tidak perlu diinisiasi pada page tertentu
          // dan dapat digunakan di seluruh page dengan menggunakan fungsi
          // Consumer pada library provider
          // ChangeNotifierProvider(create: (context) => PreferencesProvider()),
        ],
        child: MaterialApp(
          // digunakan untuk direct navigation ke page tertentu dari luar context, misal dari service
          // biasanya digunakan untuk push notification agar dapat langsung ke page tertentu
          // navigatorKey: navigatorKey,
          // name apps
          title: '',
          theme: AppStyles.themeData(),
          // initial route splash page
          initialRoute: Routes.splashPage,
          // routing apps
          routes: AppRouter.routingApp,
        ),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 0.8, // agar text sama di semua device
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
''';
  }
}
