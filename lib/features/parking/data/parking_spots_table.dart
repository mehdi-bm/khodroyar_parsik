import 'package:drift/drift.dart';

import '../../vehicles/data/vehicles_table.dart';

/// Where a vehicle was last parked — at most one row per vehicle. Saving a
/// new spot replaces the previous one; this is deliberately "where is it
/// right now", not a parking history log.
@TableIndex(name: 'idx_parking_spots_vehicle', columns: {#vehicleId})
class ParkingSpots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();
}
