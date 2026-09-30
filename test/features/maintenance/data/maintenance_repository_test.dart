import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/maintenance/data/maintenance_repository.dart';
import 'package:caryar/features/vehicles/data/vehicle_repository.dart';

void main() {
  late AppDatabase db;
  late VehicleRepository vehicles;
  late MaintenanceRepository maintenance;

  setUp(() {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
    vehicles = VehicleRepository(db);
    maintenance = MaintenanceRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('records show up in watchForVehicle, newest first', () async {
    final vehicleId = await vehicles.addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 87450,
    );

    await maintenance.addRecord(
      vehicleId: vehicleId,
      title: 'تعویض فیلتر هوا',
      category: 'airFilter',
      date: DateTime(2026, 1, 1),
      mileage: 80000,
    );
    await maintenance.addRecord(
      vehicleId: vehicleId,
      title: 'تعویض روغن موتور',
      category: 'engineOil',
      date: DateTime(2026, 5, 20),
      mileage: 87450,
      cost: 1500000,
      nextServiceMileage: 92450,
    );

    final records = await maintenance.watchForVehicle(vehicleId).first;
    expect(records, hasLength(2));
    expect(records.first.title, 'تعویض روغن موتور');
    expect(records.first.cost, 1500000);
    expect(records.first.nextServiceMileage, 92450);
  });

  test('deleting a vehicle cascades to its maintenance records', () async {
    final vehicleId = await vehicles.addVehicle(
      name: 'دنا',
      currentMileage: 1000,
    );
    await maintenance.addRecord(
      vehicleId: vehicleId,
      title: 'سرویس عمومی',
      category: 'generalService',
      date: DateTime(2026, 2, 1),
      mileage: 1000,
    );

    await vehicles.deleteVehicle(vehicleId);

    expect(await maintenance.watchForVehicle(vehicleId).first, isEmpty);
  });

  test('updateRecord persists changed fields', () async {
    final vehicleId = await vehicles.addVehicle(
      name: 'پراید',
      currentMileage: 500,
    );
    final id = await maintenance.addRecord(
      vehicleId: vehicleId,
      title: 'شمع موتور',
      category: 'sparkPlugs',
      date: DateTime(2026, 3, 1),
      mileage: 500,
    );

    await maintenance.updateRecord(
      id: id,
      vehicleId: vehicleId,
      title: 'تعویض شمع موتور',
      category: 'sparkPlugs',
      date: DateTime(2026, 3, 2),
      mileage: 550,
      cost: 300000,
    );

    final updated = await maintenance.getById(id);
    expect(updated?.title, 'تعویض شمع موتور');
    expect(updated?.mileage, 550);
    expect(updated?.cost, 300000);
  });
}
