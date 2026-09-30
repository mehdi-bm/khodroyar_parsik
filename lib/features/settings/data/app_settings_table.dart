import 'package:drift/drift.dart';

import '../../vehicles/data/vehicles_table.dart';

/// Single-row table (always id = 0) holding app-wide preferences. Named
/// `AppSettings` (not `AppSetting`) so drift's generated row class becomes
/// the singular `AppSetting` without a naming collision.
class AppSettings extends Table {
  IntColumn get id => integer()();
  IntColumn get activeVehicleId => integer().nullable().references(
    Vehicles,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get serviceReminderDaysBefore =>
      integer().withDefault(const Constant(7))();
  IntColumn get documentReminderDaysBefore =>
      integer().withDefault(const Constant(7))();
  TextColumn get distanceUnit => text().withDefault(const Constant('km'))();
  TextColumn get fuelUnit => text().withDefault(const Constant('liter'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
