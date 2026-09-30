import 'package:drift/drift.dart';

import '../../vehicles/data/vehicles_table.dart';

/// Standalone vehicle costs that aren't already captured by
/// [MaintenanceRecords] or [FuelRecords] (insurance, inspection, car wash,
/// accessories, ...) — reports add all three tables together for a total,
/// so a cost must live in exactly one of them, never duplicated.
@TableIndex(name: 'idx_expense_records_vehicle', columns: {#vehicleId})
class ExpenseRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  TextColumn get category => text()();
  IntColumn get amount => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
