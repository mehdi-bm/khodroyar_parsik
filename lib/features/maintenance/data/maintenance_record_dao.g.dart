// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_record_dao.dart';

// ignore_for_file: type=lint
mixin _$MaintenanceRecordDaoMixin on DatabaseAccessor<AppDatabase> {
  $VehiclesTable get vehicles => attachedDatabase.vehicles;
  $MaintenanceRecordsTable get maintenanceRecords =>
      attachedDatabase.maintenanceRecords;
  MaintenanceRecordDaoManager get managers => MaintenanceRecordDaoManager(this);
}

class MaintenanceRecordDaoManager {
  final _$MaintenanceRecordDaoMixin _db;
  MaintenanceRecordDaoManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db.attachedDatabase, _db.vehicles);
  $$MaintenanceRecordsTableTableManager get maintenanceRecords =>
      $$MaintenanceRecordsTableTableManager(
        _db.attachedDatabase,
        _db.maintenanceRecords,
      );
}
