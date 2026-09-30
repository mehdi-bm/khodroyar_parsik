import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/fuel/data/fuel_repository.dart';
import 'package:caryar/features/vehicles/data/vehicle_repository.dart';

void main() {
  late AppDatabase db;
  late VehicleRepository vehicles;
  late FuelRepository fuel;
  late int vehicleId;

  setUp(() async {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
    vehicles = VehicleRepository(db);
    fuel = FuelRepository(db);
    vehicleId = await vehicles.addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 80000,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('addRecord computes and stores pricePerLiter', () async {
    await fuel.addRecord(
      vehicleId: vehicleId,
      date: DateTime(2026, 1, 1),
      mileage: 80000,
      fuelAmountLiters: 35,
      totalCost: 1225000,
      isFullTank: true,
    );

    final saved = (await fuel.watchForVehicle(vehicleId).first).single;
    expect(saved.pricePerLiter, 35000);
  });

  test('records show up newest first', () async {
    await fuel.addRecord(
      vehicleId: vehicleId,
      date: DateTime(2026, 1, 1),
      mileage: 80000,
      fuelAmountLiters: 35,
      totalCost: 1225000,
      isFullTank: true,
    );
    await fuel.addRecord(
      vehicleId: vehicleId,
      date: DateTime(2026, 2, 1),
      mileage: 80500,
      fuelAmountLiters: 37,
      totalCost: 1295000,
      isFullTank: true,
    );

    final records = await fuel.watchForVehicle(vehicleId).first;
    expect(records, hasLength(2));
    expect(records.first.mileage, 80500);
  });

  test('deleting a vehicle cascades to its fuel records', () async {
    await fuel.addRecord(
      vehicleId: vehicleId,
      date: DateTime(2026, 1, 1),
      mileage: 80000,
      fuelAmountLiters: 35,
      totalCost: 1225000,
      isFullTank: true,
    );

    await vehicles.deleteVehicle(vehicleId);

    expect(await fuel.watchForVehicle(vehicleId).first, isEmpty);
  });

  test('updateRecord recomputes pricePerLiter', () async {
    final id = await fuel.addRecord(
      vehicleId: vehicleId,
      date: DateTime(2026, 1, 1),
      mileage: 80000,
      fuelAmountLiters: 35,
      totalCost: 1225000,
      isFullTank: true,
    );

    await fuel.updateRecord(
      id: id,
      vehicleId: vehicleId,
      date: DateTime(2026, 1, 1),
      mileage: 80000,
      fuelAmountLiters: 40,
      totalCost: 1400000,
      isFullTank: true,
    );

    final updated = await fuel.getById(id);
    expect(updated?.fuelAmountLiters, 40);
    expect(updated?.pricePerLiter, 35000);
  });
}
