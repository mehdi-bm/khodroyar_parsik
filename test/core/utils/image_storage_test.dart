import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:caryar/core/utils/image_storage.dart';

class _FakePathProviderPlatform extends PathProviderPlatform {
  _FakePathProviderPlatform(this.documentsPath);

  final String documentsPath;

  @override
  Future<String?> getApplicationDocumentsPath() async => documentsPath;
}

void main() {
  late Directory tempDir;
  late String sourcePath;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('caryar_image_storage');
    PathProviderPlatform.instance = _FakePathProviderPlatform(tempDir.path);

    sourcePath = p.join(tempDir.path, 'picked_photo.jpg');
    await File(sourcePath).writeAsBytes([1, 2, 3]);
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test(
    'copies the source file into a subfolder of the documents dir',
    () async {
      final targetPath = await ImageStorage.persist(
        sourcePath,
        folder: 'vehicles',
      );

      expect(await File(targetPath).exists(), isTrue);
      expect(p.dirname(targetPath), p.join(tempDir.path, 'vehicles'));
      expect(await File(targetPath).readAsBytes(), [1, 2, 3]);
    },
  );

  test('preserves the source file extension', () async {
    final targetPath = await ImageStorage.persist(
      sourcePath,
      folder: 'documents',
    );

    expect(p.extension(targetPath), '.jpg');
  });

  test('two consecutive persists of the same source never collide', () async {
    final first = await ImageStorage.persist(sourcePath, folder: 'vehicles');
    final second = await ImageStorage.persist(sourcePath, folder: 'vehicles');

    expect(first, isNot(second));
    expect(await File(first).exists(), isTrue);
    expect(await File(second).exists(), isTrue);
  });

  test('creates the target folder when it does not exist yet', () async {
    final targetDir = Directory(p.join(tempDir.path, 'brand_new_folder'));
    expect(await targetDir.exists(), isFalse);

    await ImageStorage.persist(sourcePath, folder: 'brand_new_folder');

    expect(await targetDir.exists(), isTrue);
  });
}
