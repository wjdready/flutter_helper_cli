import 'dart:io';

Future<void> _cleanFlutterProject(String path) async {

  print('\n====> clean $path\n');

  // 在该目录执行flutter clean
  final process = await Process.start(
    'flutter',
    ['clean'],
    workingDirectory: path,
    runInShell: true,
  );

  // 输出命令执行结果
  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);
  await process.exitCode;
}

void main(List<String> args) async {
  final workdir = Directory.current.absolute;

  // 递归查找所有包含pubspec.yaml的目录
  await for (final entity in workdir.list(recursive: true)) {
    final pubspec = File('${entity.path}/pubspec.yaml');
    if (await pubspec.exists()) {
      if (entity is Directory) {
        if (entity.path
            .split(Platform.pathSeparator)
            .any((part) => part.startsWith('.'))) {
          continue;
        }

        await _cleanFlutterProject(entity.path);
      }
    }
  }

  final currentDir = Directory.current;
  final currentPubspec = File('${currentDir.path}/pubspec.yaml');
  if (currentPubspec.existsSync()) {
    await _cleanFlutterProject(currentDir.path);
  }
}
