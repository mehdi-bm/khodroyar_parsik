import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/settings/data/backup_service.dart';
import 'package:drift/drift.dart' show Value;

class _FakePathProviderPlatform extends PathProviderPlatform {
  _FakePathProviderPlatform(this.documentsPath, this.tempPath);

  final String documentsPath;
  final String tempPath;

  @override
  Future<String?> getApplicationDocumentsPath() async => documentsPath;

  @override
  Future<String?> getTemporaryPath() async => tempPath;
}

void main() {
  late Directory tempRoot;
  late Directory documentsDir;
  late Directory cacheDir;
  late String dbPath;

  setUp(() async {
    tempRoot = await Directory.systemTemp.createTemp('caryar_backup_test');
    documentsDir = Directory('${tempRoot.path}/documents')
      ..createSync(recursive: true);
    cacheDir = Directory('${tempRoot.path}/cache')..createSync(recursive: true);
    PathProviderPlatform.instance = _FakePathProviderPlatform(
      documentsDir.path,
      cacheDir.path,
    );
    dbPath = '${documentsDir.path}/khodroyar.sqlite';
  });

  tearDown(() async {
    if (await tempRoot.exists()) {
      await tempRoot.delete(recursive: true);
    }
  });

  test('createBackup copies a real, non-empty sqlite file', () async {
    final db = AppDatabase.withExecutor(NativeDatabase(File(dbPath)));
    await db.vehicleDao.insertVehicle(
      const VehiclesCompanion(name: Value('پژو ۲۰۶')),
    );
    final service = BackupService(db);

    final backup = await service.createBackup();

    expect(await backup.exists(), isTrue);
    expect(await backup.length(), greaterThan(0));
    expect(await service.looksLikeSqliteDatabase(backup), isTrue);

    await db.close();
  });

  test('looksLikeSqliteDatabase rejects an unrelated file', () async {
    final db = AppDatabase.withExecutor(NativeDatabase(File(dbPath)));
    final service = BackupService(db);

    final notADatabase = File('${tempRoot.path}/not_a_db.txt');
    await notADatabase.writeAsString('this is just some text, not sqlite');

    expect(await service.looksLikeSqliteDatabase(notADatabase), isFalse);

    await db.close();
  });

  test(
    'looksLikeSqliteDatabase rejects a file shorter than the header',
    () async {
      final db = AppDatabase.withExecutor(NativeDatabase(File(dbPath)));
      final service = BackupService(db);

      final tinyFile = File('${tempRoot.path}/tiny.sqlite');
      await tinyFile.writeAsBytes([1, 2, 3]);

      expect(await service.looksLikeSqliteDatabase(tinyFile), isFalse);

      await db.close();
    },
  );

  test(
    'restoreFromFile replaces the live database with the backup contents',
    () async {
      // Seed the "current" database with one vehicle, then back it up.
      final original = AppDatabase.withExecutor(NativeDatabase(File(dbPath)));
      await original.vehicleDao.insertVehicle(
        const VehiclesCompanion(name: Value('پژو ۲۰۶')),
      );
      final backupService = BackupService(original);
      final backupFile = await backupService.createBackup();
      await original.close();

      // Simulate the user changing data after the backup was made.
      final beforeRestore = AppDatabase.withExecutor(
        NativeDatabase(File(dbPath)),
      );
      await beforeRestore.vehicleDao.insertVehicle(
        const VehiclesCompanion(name: Value('سمند')),
      );
      final restoreService = BackupService(beforeRestore);

      await restoreService.restoreFromFile(backupFile);

      await beforeRestore.close();

      // Reopening the same path must show only the backed-up vehicle —
      // the post-backup "سمند" insert must be gone.
      final afterRestore = AppDatabase.withExecutor(
        NativeDatabase(File(dbPath)),
      );
      final vehicles = await afterRestore.vehicleDao.watchAll().first;
      expect(vehicles, hasLength(1));
      expect(vehicles.single.name, 'پژو ۲۰۶');

      await afterRestore.close();
    },
  );

  test(
    'restoration keeps the live database and subscriptions usable',
    () async {
      final db = AppDatabase.withExecutor(NativeDatabase(File(dbPath)));
      await db.vehicleDao.insertVehicle(
        const VehiclesCompanion(name: Value('پژو')),
      );
      final service = BackupService(db);
      final file = await service.createBackup();
      await db.vehicleDao.insertVehicle(
        const VehiclesCompanion(name: Value('سمند')),
      );
      final restored = db.vehicleDao.watchAll().firstWhere(
        (rows) => rows.length == 1,
      );
      await service.restoreFromFile(file);
      expect((await restored).single.name, 'پژو');
      await db.vehicleDao.insertVehicle(
        const VehiclesCompanion(name: Value('جدید')),
      );
      expect(await db.select(db.vehicles).get(), hasLength(2));
      await db.close();
    },
  );

  test('invalid restore does not close or modify the live database', () async {
    final db = AppDatabase.withExecutor(NativeDatabase(File(dbPath)));
    await db.vehicleDao.insertVehicle(
      const VehiclesCompanion(name: Value('پژو')),
    );
    final bad = File('${cacheDir.path}/bad.sqlite');
    await bad.writeAsString('SQLite format 3 invalid content');
    await expectLater(
      BackupService(db).restoreFromFile(bad),
      throwsA(anything),
    );
    expect((await db.select(db.vehicles).get()).single.name, 'پژو');
    await db.close();
  });

  test('photos travel with the backup and receive safe local paths', () async {
    final db = AppDatabase.withExecutor(NativeDatabase(File(dbPath)));
    final photo = File('${documentsDir.path}/photo.png');
    final content = [137, 80, 78, 71, 1, 2, 3, 4];
    await photo.writeAsBytes(content);
    await db.vehicleDao.insertVehicle(
      VehiclesCompanion(name: const Value('پژو'), photoPath: Value(photo.path)),
    );
    final service = BackupService(db);
    final file = await service.createBackup();
    await photo.delete();
    await service.restoreFromFile(file);
    final row = (await db.select(db.vehicles).get()).single;
    expect(row.photoPath, isNot(photo.path));
    expect(await File(row.photoPath!).readAsBytes(), content);
    await db.close();
  });
}
