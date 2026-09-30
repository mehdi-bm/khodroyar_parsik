import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import 'package:caryar/core/database/app_database.dart';
import 'package:drift/drift.dart' show Value;

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('inserting a vehicle makes it show up in watchAll', () async {
    await db.vehicleDao.insertVehicle(
      const VehiclesCompanion(
        name: Value('پژو ۲۰۶'),
        currentMileage: Value(87450),
      ),
    );

    final all = await db.vehicleDao.watchAll().first;
    expect(all, hasLength(1));
    expect(all.single.name, 'پژو ۲۰۶');
    expect(all.single.currentMileage, 87450);
  });

  test('deleting a vehicle cascades to its maintenance records', () async {
    final vehicleId = await db.vehicleDao.insertVehicle(
      const VehiclesCompanion(name: Value('دنا')),
    );
    await db.maintenanceRecordDao.insertRecord(
      MaintenanceRecordsCompanion.insert(
        vehicleId: vehicleId,
        title: 'تعویض روغن موتور',
        category: 'engineOil',
        date: DateTime(2026, 5, 20),
        mileage: 87450,
      ),
    );

    expect(
      await db.maintenanceRecordDao.watchForVehicle(vehicleId).first,
      hasLength(1),
    );

    await db.vehicleDao.deleteVehicle(vehicleId);

    expect(
      await db.maintenanceRecordDao.watchForVehicle(vehicleId).first,
      isEmpty,
    );
  });

  test('document only stores expirationDate, not "days remaining"', () async {
    final vehicleId = await db.vehicleDao.insertVehicle(
      const VehiclesCompanion(name: Value('پراید')),
    );
    // Expiration dates are calendar dates, not timestamps — drift also
    // only persists dateTime columns at second precision, so a
    // microsecond-precise DateTime.now() wouldn't round-trip exactly.
    final today = DateTime.now();
    final expiresAt = DateTime(today.year, today.month, today.day + 84);
    await db.documentDao.insertDocument(
      DocumentsCompanion.insert(
        vehicleId: vehicleId,
        title: 'بیمه شخص ثالث',
        type: 'insurance',
        expirationDate: expiresAt,
      ),
    );

    final saved =
        (await db.documentDao.watchForVehicle(vehicleId).first).single;
    expect(saved.expirationDate, expiresAt);
  });

  test('app settings row is created with defaults on first read', () async {
    final settings = await db.appSettingsDao.watchSettings().first;
    expect(settings.themeMode, 'system');
    expect(settings.notificationsEnabled, isTrue);
    expect(settings.distanceUnit, 'km');
  });

  group('schema migration v2 -> v3 (per-vehicle indexes)', () {
    test(
      'adds the indexes to an existing v2 database without data loss',
      () async {
        final tempDir = await Directory.systemTemp.createTemp(
          'caryar_migration',
        );
        final dbFile = File(p.join(tempDir.path, 'test.sqlite'));

        try {
          // Simulate an existing v2 install: create a fresh (current-schema)
          // database, then strip back to what v2 actually looked like — no
          // indexes, none of the v4 additions, and the schema version
          // pragma rewound to 2 — before reopening it as AppDatabase would
          // for a real user upgrading the app straight from v2 to current.
          final seedDb = AppDatabase.withExecutor(NativeDatabase(dbFile));
          final vehicleId = await seedDb.vehicleDao.insertVehicle(
            const VehiclesCompanion(name: Value('پژو ۲۰۶')),
          );
          for (final indexName in [
            'idx_maintenance_records_vehicle',
            'idx_maintenance_schedules_vehicle_category',
            'idx_fuel_records_vehicle',
            'idx_expense_records_vehicle',
            'idx_documents_vehicle',
          ]) {
            await seedDb.customStatement('DROP INDEX $indexName');
          }
          // v4 additions — a real v2 install predates all of these, so a
          // seed built from the current schema must have them stripped too,
          // or the v2->v4 migration below hits "duplicate column" errors
          // trying to (re-)add columns that were never actually missing.
          for (final columnName in [
            'oil_type',
            'oil_filter_model',
            'air_filter_model',
            'cabin_filter_model',
            'tire_size',
            'battery_model',
            'spark_plug_model',
          ]) {
            await seedDb.customStatement(
              'ALTER TABLE vehicles DROP COLUMN $columnName',
            );
          }
          await seedDb.customStatement('DROP TABLE parking_spots');
          await seedDb.customStatement('PRAGMA user_version = 2');
          await seedDb.close();

          // Reopening should detect schemaVersion 2 -> current and run
          // every intermediate migration step in order, not throw (e.g.
          // from an index/column already existing, or a typo'd reference).
          final upgradedDb = AppDatabase.withExecutor(NativeDatabase(dbFile));
          final indexNames = await upgradedDb
              .customSelect(
                "SELECT name FROM sqlite_master WHERE type = 'index' AND name LIKE 'idx_%'",
              )
              .map((row) => row.read<String>('name'))
              .get();

          expect(
            indexNames,
            containsAll([
              'idx_maintenance_records_vehicle',
              'idx_maintenance_schedules_vehicle_category',
              'idx_fuel_records_vehicle',
              'idx_expense_records_vehicle',
              'idx_documents_vehicle',
            ]),
          );

          // The v4 step must also have run — new vehicle columns exist and
          // are queryable, and the parking_spots table was created.
          expect(
            (await upgradedDb
                    .customSelect(
                      "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'parking_spots'",
                    )
                    .get())
                .isNotEmpty,
            isTrue,
          );

          // Pre-existing data must survive the migration untouched.
          final vehicles = await upgradedDb.vehicleDao.watchAll().first;
          expect(vehicles.single.id, vehicleId);
          expect(vehicles.single.name, 'پژو ۲۰۶');

          await upgradedDb.close();
        } finally {
          await tempDir.delete(recursive: true);
        }
      },
    );
  });
}
