import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/expenses/data/expense_repository.dart';
import 'package:caryar/features/vehicles/data/vehicle_repository.dart';

void main() {
  late AppDatabase db;
  late VehicleRepository vehicles;
  late ExpenseRepository expenses;
  late int vehicleId;

  setUp(() async {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
    vehicles = VehicleRepository(db);
    expenses = ExpenseRepository(db);
    vehicleId = await vehicles.addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 80000,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('records show up newest first', () async {
    await expenses.addRecord(
      vehicleId: vehicleId,
      category: 'insurance',
      amount: 4500000,
      date: DateTime(2026, 1, 1),
    );
    await expenses.addRecord(
      vehicleId: vehicleId,
      category: 'carWash',
      amount: 150000,
      date: DateTime(2026, 2, 1),
    );

    final records = await expenses.watchForVehicle(vehicleId).first;
    expect(records, hasLength(2));
    expect(records.first.category, 'carWash');
  });

  test('deleting a vehicle cascades to its expense records', () async {
    await expenses.addRecord(
      vehicleId: vehicleId,
      category: 'insurance',
      amount: 4500000,
      date: DateTime(2026, 1, 1),
    );

    await vehicles.deleteVehicle(vehicleId);

    expect(await expenses.watchForVehicle(vehicleId).first, isEmpty);
  });

  test('updateRecord persists changed fields', () async {
    final id = await expenses.addRecord(
      vehicleId: vehicleId,
      category: 'carWash',
      amount: 150000,
      date: DateTime(2026, 1, 1),
    );

    await expenses.updateRecord(
      id: id,
      vehicleId: vehicleId,
      category: 'tires',
      amount: 3200000,
      date: DateTime(2026, 1, 5),
      description: 'دو حلقه لاستیک جلو',
    );

    final updated = await expenses.getById(id);
    expect(updated?.category, 'tires');
    expect(updated?.amount, 3200000);
    expect(updated?.description, 'دو حلقه لاستیک جلو');
  });
}
