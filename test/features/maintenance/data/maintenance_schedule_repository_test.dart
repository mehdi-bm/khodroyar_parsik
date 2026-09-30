import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/maintenance/data/maintenance_schedule_repository.dart';
import 'package:caryar/features/vehicles/data/vehicle_repository.dart';

void main() {
  late AppDatabase db;
  late VehicleRepository vehicles;
  late MaintenanceScheduleRepository schedules;
  late int vehicleId;

  setUp(() async {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
    vehicles = VehicleRepository(db);
    schedules = MaintenanceScheduleRepository(db);
    vehicleId = await vehicles.addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 80000,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('does nothing when no next-service hint is given', () async {
    await schedules.upsertFromRecord(
      vehicleId: vehicleId,
      category: 'engineOil',
      title: 'تعویض روغن موتور',
      serviceMileage: 80000,
      serviceDate: DateTime(2026, 1, 1),
    );

    expect(await schedules.watchForVehicle(vehicleId).first, isEmpty);
  });

  test('creates a schedule from a mileage-only hint', () async {
    await schedules.upsertFromRecord(
      vehicleId: vehicleId,
      category: 'engineOil',
      title: 'تعویض روغن موتور',
      serviceMileage: 80000,
      serviceDate: DateTime(2026, 1, 1),
      nextServiceMileage: 85000,
    );

    final saved = (await schedules.watchForVehicle(vehicleId).first).single;
    expect(saved.intervalMileage, 5000);
    expect(saved.intervalDays, isNull);
    expect(saved.lastServiceMileage, 80000);
  });

  test(
    'a later hint updates the baseline and preserves the other dimension',
    () async {
      await schedules.upsertFromRecord(
        vehicleId: vehicleId,
        category: 'engineOil',
        title: 'تعویض روغن موتور',
        serviceMileage: 80000,
        serviceDate: DateTime(2026, 1, 1),
        nextServiceMileage: 85000,
        nextServiceDate: DateTime(2026, 7, 1),
      );

      // Second service only gives a mileage hint this time — the date
      // interval from before should survive, and the baseline should move.
      await schedules.upsertFromRecord(
        vehicleId: vehicleId,
        category: 'engineOil',
        title: 'تعویض روغن موتور',
        serviceMileage: 85200,
        serviceDate: DateTime(2026, 2, 1),
        nextServiceMileage: 90200,
      );

      final all = await schedules.watchForVehicle(vehicleId).first;
      expect(all, hasLength(1));
      final saved = all.single;
      expect(saved.intervalMileage, 5000);
      expect(saved.intervalDays, 181); // preserved from the first hint
      expect(saved.lastServiceMileage, 85200);
      expect(saved.lastServiceDate, DateTime(2026, 2, 1));
    },
  );

  test('different categories get separate schedules', () async {
    await schedules.upsertFromRecord(
      vehicleId: vehicleId,
      category: 'engineOil',
      title: 'تعویض روغن موتور',
      serviceMileage: 80000,
      serviceDate: DateTime(2026, 1, 1),
      nextServiceMileage: 85000,
    );
    await schedules.upsertFromRecord(
      vehicleId: vehicleId,
      category: 'tires',
      title: 'تعویض لاستیک',
      serviceMileage: 80000,
      serviceDate: DateTime(2026, 1, 1),
      nextServiceMileage: 100000,
    );

    expect(await schedules.watchForVehicle(vehicleId).first, hasLength(2));
  });
}
