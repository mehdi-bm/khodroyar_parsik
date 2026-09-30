import 'package:drift/drift.dart';

import '../../vehicles/data/vehicles_table.dart';

/// Insurance, technical inspection, and other vehicle documents. Only the
/// expiration date is stored — "N days remaining" is always computed at
/// read time from [expirationDate], never persisted.
@TableIndex(name: 'idx_documents_vehicle', columns: {#vehicleId})
class Documents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text().withLength(min: 1, max: 150)();
  TextColumn get type => text()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get expirationDate => dateTime()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
