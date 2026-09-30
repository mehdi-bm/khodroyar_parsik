// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_spot_dao.dart';

// ignore_for_file: type=lint
mixin _$ParkingSpotDaoMixin on DatabaseAccessor<AppDatabase> {
  $VehiclesTable get vehicles => attachedDatabase.vehicles;
  $ParkingSpotsTable get parkingSpots => attachedDatabase.parkingSpots;
  ParkingSpotDaoManager get managers => ParkingSpotDaoManager(this);
}

class ParkingSpotDaoManager {
  final _$ParkingSpotDaoMixin _db;
  ParkingSpotDaoManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db.attachedDatabase, _db.vehicles);
  $$ParkingSpotsTableTableManager get parkingSpots =>
      $$ParkingSpotsTableTableManager(_db.attachedDatabase, _db.parkingSpots);
}
