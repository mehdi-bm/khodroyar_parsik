import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/documents/data/document_dao.dart';
import '../../features/documents/data/documents_table.dart';
import '../../features/expenses/data/expense_record_dao.dart';
import '../../features/expenses/data/expense_records_table.dart';
import '../../features/fuel/data/fuel_record_dao.dart';
import '../../features/fuel/data/fuel_records_table.dart';
import '../../features/maintenance/data/maintenance_record_dao.dart';
import '../../features/maintenance/data/maintenance_records_table.dart';
import '../../features/maintenance/data/maintenance_schedule_dao.dart';
import '../../features/maintenance/data/maintenance_schedules_table.dart';
import '../../features/parking/data/parking_spot_dao.dart';
import '../../features/parking/data/parking_spots_table.dart';
import '../../features/settings/data/app_settings_dao.dart';
import '../../features/settings/data/app_settings_table.dart';
import '../../features/vehicles/data/vehicle_dao.dart';
import '../../features/vehicles/data/vehicles_table.dart';

part 'app_database.g.dart';

/// The single offline SQLite database for خودرویار. All tables live in
/// feature `data/` folders (feature-based architecture); this file only
/// composes them into one physical database file.
@DriftDatabase(
  tables: [
    Vehicles,
    MaintenanceRecords,
    MaintenanceSchedules,
    FuelRecords,
    ExpenseRecords,
    Documents,
    AppSettings,
    ParkingSpots,
  ],
  daos: [
    VehicleDao,
    MaintenanceRecordDao,
    MaintenanceScheduleDao,
    FuelRecordDao,
    ExpenseRecordDao,
    DocumentDao,
    AppSettingsDao,
    ParkingSpotDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.withExecutor(super.executor);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      // Seed the single settings row up front so AppSettingsDao.watchSettings()
      // can be a plain select-watch with no lazy-insert side effect.
      await into(
        appSettings,
      ).insert(const AppSettingsCompanion(id: Value(kAppSettingsRowId)));
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(appSettings, appSettings.activeVehicleId);
      }
      if (from < 3) {
        // Every per-vehicle table is queried filtered by vehicleId (and
        // schedules additionally by category) — sqlite does not index
        // foreign-key columns automatically, so a full table scan was the
        // only plan available for these lookups on existing installs.
        await m.createIndex(idxMaintenanceRecordsVehicle);
        await m.createIndex(idxMaintenanceSchedulesVehicleCategory);
        await m.createIndex(idxFuelRecordsVehicle);
        await m.createIndex(idxExpenseRecordsVehicle);
        await m.createIndex(idxDocumentsVehicle);
      }
      if (from < 4) {
        // Consumable-part specs ("دفترچه مشخصات قطعات مصرفی").
        await m.addColumn(vehicles, vehicles.oilType);
        await m.addColumn(vehicles, vehicles.oilFilterModel);
        await m.addColumn(vehicles, vehicles.airFilterModel);
        await m.addColumn(vehicles, vehicles.cabinFilterModel);
        await m.addColumn(vehicles, vehicles.tireSize);
        await m.addColumn(vehicles, vehicles.batteryModel);
        await m.addColumn(vehicles, vehicles.sparkPlugModel);
        await m.createTable(parkingSpots);
        await m.createIndex(idxParkingSpotsVehicle);
      }
    },
    beforeOpen: (details) async {
      // Foreign keys are off by default in sqlite3; without this, the
      // ON DELETE CASCADE on every child table's vehicleId is a no-op.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'khodroyar');
  }
}
