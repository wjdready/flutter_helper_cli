import 'dart:io';
import 'package:path/path.dart' as path;

void main(List<String> args) {
  final workdir = Directory.current.absolute;

  String dirarg = 'example';

  final mutableArgs = List<String>.from(args);

  if (mutableArgs.contains('--dir')) {
    final index = mutableArgs.indexOf('--dir');
    if (index != -1 && (index + 1) < mutableArgs.length) {
      dirarg = mutableArgs[index + 1];
      mutableArgs.removeAt(index);
      mutableArgs.removeAt(index);
    }
  }

  final exampleDir = Directory(path.join(workdir.path, dirarg));
  if (!exampleDir.existsSync()) {
    print('目录 $dirarg 不存在');
    return;
  }

  // 创建build目录
  final buildDir = Directory(path.join(workdir.path, 'build'));
  if (!buildDir.existsSync()) {
    buildDir.createSync();
  }

  // 创建链接 - 遍历example目录下所有内容
  exampleDir.listSync(recursive: false).forEach((entity) {
    final targetPath = path.join(buildDir.path, path.basename(entity.path));
    final targetFile = File(targetPath);
    final targetDir = Directory(targetPath);
    final link = Link(targetPath);

    if (!link.existsSync() &&
        !targetFile.existsSync() &&
        !targetDir.existsSync()) {
      link.createSync(entity.path);
    }
  });

  // 进入build目录并执行flutter create
  final result = Process.runSync(
      'flutter', ['create', buildDir.path, ...mutableArgs],
      runInShell: true);
  print(result.stdout);
}
