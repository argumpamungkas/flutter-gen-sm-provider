import 'dart:io';

class GenPackages {
  void installPackages() {
    print('\nInstalling packages...');
    print(
        '\nProvider, Flutter ScreenUtil, HTTP, Shared Preferences, and GetIt packages are being installed...\n');

    final package = [
      'pub',
      'add',
      'provider',
      'flutter_screenutil',
      'http',
      'shared_preferences',
      'get_it',
    ];

    final result = Process.runSync(
      'flutter',
      package,
      runInShell: true,
    );

    if (result.stdout.toString().isNotEmpty) {
      print(result.stdout);
    }

    if (result.exitCode != 0) {
      stderr.writeln(result.stderr);
      stderr.writeln('Gagal menambahkan package.');
      exitCode = 1;
      return;
    }

    print('Packages installed successfully!');
  }
}
