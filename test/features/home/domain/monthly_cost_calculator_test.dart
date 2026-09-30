import 'package:flutter_test/flutter_test.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/home/domain/monthly_cost_calculator.dart';

MaintenanceRecord _maintenance({required DateTime date, required int cost}) {
  return MaintenanceRecord(
    id: 1,
    vehicleId: 1,
    title: 'سرویس',
    category: 'engineOil',
    date: date,
    mileage: 1000,
    cost: cost,
    description: null,
    photoPath: null,
    nextServiceMileage: null,
    nextServiceDate: null,
    createdAt: date,
  );
}

FuelRecord _fuel({required DateTime date, required int totalCost}) {
  return FuelRecord(
    id: 1,
    vehicleId: 1,
    date: date,
    mileage: 1000,
    fuelAmountLiters: 35,
    totalCost: totalCost,
    pricePerLiter: null,
    isFullTank: true,
    notes: null,
    createdAt: date,
  );
}

ExpenseRecord _expense({required DateTime date, required int amount}) {
  return ExpenseRecord(
    id: 1,
    vehicleId: 1,
    category: 'insurance',
    amount: amount,
    date: date,
    description: null,
    photoPath: null,
    createdAt: date,
  );
}

void main() {
  test('sums costs from all three tables within the given month', () {
    final total = computeMonthlyCost(
      maintenanceRecords: [
        _maintenance(date: Jalali(1405, 2, 10).toDateTime(), cost: 1500000),
      ],
      fuelRecords: [
        _fuel(date: Jalali(1405, 2, 15).toDateTime(), totalCost: 1225000),
      ],
      expenseRecords: [
        _expense(date: Jalali(1405, 2, 20).toDateTime(), amount: 125000),
      ],
      month: Jalali(1405, 2, 1).toDateTime(),
    );
    expect(total, 1500000 + 1225000 + 125000);
  });

  test('excludes records from other months', () {
    final total = computeMonthlyCost(
      maintenanceRecords: [
        _maintenance(date: Jalali(1405, 1, 10).toDateTime(), cost: 1500000),
      ],
      fuelRecords: [
        _fuel(date: Jalali(1405, 3, 15).toDateTime(), totalCost: 1225000),
      ],
      expenseRecords: [
        _expense(date: Jalali(1405, 2, 20).toDateTime(), amount: 125000),
      ],
      month: Jalali(1405, 2, 1).toDateTime(),
    );
    expect(total, 125000);
  });

  test('is zero when there are no records at all', () {
    final total = computeMonthlyCost(
      maintenanceRecords: const [],
      fuelRecords: const [],
      expenseRecords: const [],
      month: Jalali(1405, 2, 1).toDateTime(),
    );
    expect(total, 0);
  });

  test('excludes records from the same month in a different year', () {
    final total = computeMonthlyCost(
      maintenanceRecords: const [],
      fuelRecords: const [],
      expenseRecords: [
        _expense(date: Jalali(1404, 2, 20).toDateTime(), amount: 125000),
      ],
      month: Jalali(1405, 2, 1).toDateTime(),
    );
    expect(total, 0);
  });
}
