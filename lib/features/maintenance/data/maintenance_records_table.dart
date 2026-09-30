import 'package:drift/drift.dart';

import '../../vehicles/data/vehicles_table.dart';

/// A completed service/repair event. `category` is free text (the list of
/// suggested categories from the master spec — engine oil, filters, brakes,
/// battery, tires, ...) lives in the UI layer, not as a DB-level enum, so new
/// categories can be added without a migration.
@TableIndex(name: 'idx_maintenance_records_vehicle', columns: {#vehicleId})
class MaintenanceRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text().withLength(min: 1, max: 150)();
  TextColumn get category => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get mileage => integer()();
  IntColumn get cost => integer().withDefault(const Constant(0))();
  TextColumn get description => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  IntColumn get nextServiceMileage => integer().nullable()();
  DateTimeColumn get nextServiceDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
