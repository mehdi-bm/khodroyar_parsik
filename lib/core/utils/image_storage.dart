import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Copies a picked image (which may live in a temp/cache location the OS
/// can clear) into the app's own documents directory so it survives for as
/// long as the record referencing it exists. Photos never leave the device.
abstract final class ImageStorage {
  // `DateTime.now().microsecondsSinceEpoch` alone isn't a safe uniqueness
  // key — on some hardware/OS clock resolutions it returns the same value
  // for calls milliseconds apart, which would make a second photo silently
  // overwrite a first one picked shortly before it. An in-process counter
  // appended alongside the timestamp guarantees uniqueness regardless of
  // clock resolution.
  static int _counter = 0;

  static Future<String> persist(
    String sourcePath, {
    required String folder,
  }) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final targetDir = Directory(p.join(docsDir.path, folder));
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }
    final fileName =
        '${DateTime.now().microsecondsSinceEpoch}_${_counter++}'
        '${p.extension(sourcePath)}';
    final targetPath = p.join(targetDir.path, fileName);
    await File(sourcePath).copy(targetPath);
    return targetPath;
  }
}
