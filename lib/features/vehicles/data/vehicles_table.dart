import 'package:drift/drift.dart';

/// The parent entity — every other record table references a vehicle.
class Vehicles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get brand => text().nullable()();
  TextColumn get model => text().nullable()();
  IntColumn get modelYear => integer().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get licensePlate => text().nullable()();
  IntColumn get currentMileage => integer().withDefault(const Constant(0))();
  TextColumn get photoPath => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  // Consumable-part specs ("دفترچه مشخصات قطعات مصرفی") — free text so the
  // user can note exactly what their vehicle takes (e.g. "5W-30 فولی
  // سینتتیک") without the app maintaining a parts database. All optional.
  TextColumn get oilType => text().nullable()();
  TextColumn get oilFilterModel => text().nullable()();
  TextColumn get airFilterModel => text().nullable()();
  TextColumn get cabinFilterModel => text().nullable()();
  TextColumn get tireSize => text().nullable()();
  TextColumn get batteryModel => text().nullable()();
  TextColumn get sparkPlugModel => text().nullable()();
}
