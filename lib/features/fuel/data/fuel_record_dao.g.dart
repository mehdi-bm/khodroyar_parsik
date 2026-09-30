// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_record_dao.dart';

// ignore_for_file: type=lint
mixin _$FuelRecordDaoMixin on DatabaseAccessor<AppDatabase> {
  $VehiclesTable get vehicles => attachedDatabase.vehicles;
  $FuelRecordsTable get fuelRecords => attachedDatabase.fuelRecords;
  FuelRecordDaoManager get managers => FuelRecordDaoManager(this);
}

class FuelRecordDaoManager {
  final _$FuelRecordDaoMixin _db;
  FuelRecordDaoManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db.attachedDatabase, _db.vehicles);
  $$FuelRecordsTableTableManager get fuelRecords =>
      $$FuelRecordsTableTableManager(_db.attachedDatabase, _db.fuelRecords);
}
