// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_dao.dart';

// ignore_for_file: type=lint
mixin _$AppSettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $VehiclesTable get vehicles => attachedDatabase.vehicles;
  $AppSettingsTable get appSettings => attachedDatabase.appSettings;
  AppSettingsDaoManager get managers => AppSettingsDaoManager(this);
}

class AppSettingsDaoManager {
  final _$AppSettingsDaoMixin _db;
  AppSettingsDaoManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db.attachedDatabase, _db.vehicles);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db.attachedDatabase, _db.appSettings);
}
