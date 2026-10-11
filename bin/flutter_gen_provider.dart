import 'dart:io';
import 'generator/gen_packages.dart';
import 'generator/gen_files.dart';

void main() {
  final packages = GenPackages();
  final genFiles = GenFiles();

  final root = Directory.current;

  if (!File('${root.path}/pubspec.yaml').existsSync()) {
    stderr.writeln(
      'Error: Jalankan command dari root project Flutter.',
    );
    exitCode = 1;
    return;
  }

  // create directory
  final directoriesAssets = [
    'assets/images',
    'assets/fonts',
  ];

  for (final path in directoriesAssets) {
    final directory = Directory('${root.path}/$path');
    directory.createSync(recursive: true);
    print('CREATE ${directory.path}');
  }
  print('\nAssets directory successfully created!');

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

  final files = genFiles.generate();

  // UPDATE main.dart
  final mainFile = File('${lib.path}/main.dart');
  final mainTemplate = genFiles.updateMainTemplate();

// replace existing main.dart content with the new template
  mainFile.writeAsStringSync(mainTemplate);

  for (final entry in files.entries) {
    final file = File('${lib.path}/${entry.key}');

// the comment, because we want to overwrite the existing files, so we don't skip them
    // if (file.existsSync()) {
    //   print('SKIP ${file.path} (sudah ada)');
    //   continue;
    // }

    file.parent.createSync(recursive: true);
    file.writeAsStringSync(entry.value.trimLeft());
    print('CREATE ${file.path}');
  }

  // INSTALLED PACKAGES
  packages.installPackages();

  print('\nFlutter structure generated successfully!');
}
