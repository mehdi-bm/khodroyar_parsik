import 'dart:async';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/notifications/notification_scheduler.dart';

/// Thin domain-facing wrapper around [VehicleDao] + the active-vehicle
/// pointer in [AppSettingsDao]. Drift's generated `Vehicle` row class is
/// used directly as the domain model — a separate DTO layer would just be
/// a redundant conversion for an app this size.
class VehicleRepository {
  VehicleRepository(this._db, [this._scheduler]);

  final AppDatabase _db;
  final NotificationScheduler? _scheduler;

  Stream<List<Vehicle>> watchAllVehicles() => _db.vehicleDao.watchAll();

  Future<Vehicle?> getVehicle(int id) => _db.vehicleDao.getById(id);

  /// The selected vehicle, falling back to the first vehicle (by creation
  /// order) when none is explicitly selected, and to `null` when there are
  /// no vehicles at all.
  Stream<Vehicle?> watchActiveVehicle() {
    late StreamController<Vehicle?> controller;
    StreamSubscription<List<Vehicle>>? vehiclesSub;
    StreamSubscription<AppSetting>? settingsSub;
    List<Vehicle>? latestVehicles;
    AppSetting? latestSettings;

    void emit() {
      final vehicles = latestVehicles;
      final settings = latestSettings;
      if (vehicles == null || settings == null) return;

      Vehicle? active;
      final activeId = settings.activeVehicleId;
      if (activeId != null) {
        for (final vehicle in vehicles) {
          if (vehicle.id == activeId) {
            active = vehicle;
            break;
          }
        }
      }
      active ??= vehicles.isEmpty ? null : vehicles.first;
      controller.add(active);
    }

    controller = StreamController<Vehicle?>.broadcast(
      onListen: () {
        vehiclesSub = watchAllVehicles().listen((vehicles) {
          latestVehicles = vehicles;
          emit();
        });
        settingsSub = _db.appSettingsDao.watchSettings().listen((settings) {
          latestSettings = settings;
          emit();
        });
      },
      onCancel: () async {
        await vehiclesSub?.cancel();
        await settingsSub?.cancel();
      },
    );
    return controller.stream;
  }

  Future<void> setActiveVehicle(int id) => _db.appSettingsDao.updateSettings(
    AppSettingsCompanion(activeVehicleId: Value(id)),
  );

  Future<int> addVehicle({
    required String name,
    String? brand,
    String? model,
    int? modelYear,
    String? color,
    String? licensePlate,
    required int currentMileage,
    String? photoPath,
    String? notes,
    String? oilType,
    String? oilFilterModel,
    String? airFilterModel,
    String? cabinFilterModel,
    String? tireSize,
    String? batteryModel,
    String? sparkPlugModel,
  }) {
    return _db.vehicleDao.insertVehicle(
      VehiclesCompanion.insert(
        name: name,
        brand: Value(brand),
        model: Value(model),
        modelYear: Value(modelYear),
        color: Value(color),
        licensePlate: Value(licensePlate),
        currentMileage: Value(currentMileage),
        photoPath: Value(photoPath),
        notes: Value(notes),
        oilType: Value(oilType),
        oilFilterModel: Value(oilFilterModel),
        airFilterModel: Value(airFilterModel),
        cabinFilterModel: Value(cabinFilterModel),
        tireSize: Value(tireSize),
        batteryModel: Value(batteryModel),
        sparkPlugModel: Value(sparkPlugModel),
      ),
    );
  }

  Future<void> updateVehicle({
    required int id,
    required String name,
    String? brand,
    String? model,
    int? modelYear,
    String? color,
    String? licensePlate,
    required int currentMileage,
    String? photoPath,
    String? notes,
    String? oilType,
    String? oilFilterModel,
    String? airFilterModel,
    String? cabinFilterModel,
    String? tireSize,
    String? batteryModel,
    String? sparkPlugModel,
  }) {
    return _db.vehicleDao.updateVehicle(
      VehiclesCompanion(
        id: Value(id),
        name: Value(name),
        brand: Value(brand),
        model: Value(model),
        modelYear: Value(modelYear),
        color: Value(color),
        licensePlate: Value(licensePlate),
        currentMileage: Value(currentMileage),
        photoPath: Value(photoPath),
        notes: Value(notes),
        oilType: Value(oilType),
        oilFilterModel: Value(oilFilterModel),
        airFilterModel: Value(airFilterModel),
        cabinFilterModel: Value(cabinFilterModel),
        tireSize: Value(tireSize),
        batteryModel: Value(batteryModel),
        sparkPlugModel: Value(sparkPlugModel),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteVehicle(int id) async {
    await _db.vehicleDao.deleteVehicle(id);
    await _scheduler?.rescheduleAll();
  }
}
