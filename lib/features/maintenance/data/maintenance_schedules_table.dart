import 'package:drift/drift.dart';

import '../../vehicles/data/vehicles_table.dart';

/// A user-defined recurring rule (e.g. "engine oil every 5,000 km or 6
/// months"), independent of whether a matching [MaintenanceRecords] entry
/// has ever been logged yet. Only the interval and the last-known baseline
/// are stored — remaining km/days are always computed at read time, never
/// persisted, per the app's rule against storing derived values.
@TableIndex(
  name: 'idx_maintenance_schedules_vehicle_category',
  columns: {#vehicleId, #category},
)
class MaintenanceSchedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text().withLength(min: 1, max: 150)();
  TextColumn get category => text()();
  IntColumn get intervalMileage => integer().nullable()();
  IntColumn get intervalDays => integer().nullable()();
  IntColumn get lastServiceMileage => integer().nullable()();
  DateTimeColumn get lastServiceDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
