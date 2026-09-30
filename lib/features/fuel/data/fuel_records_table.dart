import 'package:drift/drift.dart';

import '../../vehicles/data/vehicles_table.dart';

@TableIndex(name: 'idx_fuel_records_vehicle', columns: {#vehicleId})
class FuelRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId =>
      integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  IntColumn get mileage => integer()();
  RealColumn get fuelAmountLiters => real()();
  IntColumn get totalCost => integer()();
  RealColumn get pricePerLiter => real().nullable()();
  BoolColumn get isFullTank => boolean().withDefault(const Constant(true))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
