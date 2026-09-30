// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_schedule_dao.dart';

// ignore_for_file: type=lint
mixin _$MaintenanceScheduleDaoMixin on DatabaseAccessor<AppDatabase> {
  $VehiclesTable get vehicles => attachedDatabase.vehicles;
  $MaintenanceSchedulesTable get maintenanceSchedules =>
      attachedDatabase.maintenanceSchedules;
  MaintenanceScheduleDaoManager get managers =>
      MaintenanceScheduleDaoManager(this);
}

class MaintenanceScheduleDaoManager {
  final _$MaintenanceScheduleDaoMixin _db;
  MaintenanceScheduleDaoManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db.attachedDatabase, _db.vehicles);
  $$MaintenanceSchedulesTableTableManager get maintenanceSchedules =>
      $$MaintenanceSchedulesTableTableManager(
        _db.attachedDatabase,
        _db.maintenanceSchedules,
      );
}
