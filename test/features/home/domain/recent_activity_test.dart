import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/home/domain/recent_activity.dart';

MaintenanceRecord _maintenance({required DateTime date, required int cost}) {
  return MaintenanceRecord(
    id: 1,
    vehicleId: 1,
    title: 'تعویض روغن موتور',
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
    id: 2,
    vehicleId: 1,
    date: date,
    mileage: 1000,
    fuelAmountLiters: 40,
    totalCost: totalCost,
    pricePerLiter: null,
    isFullTank: true,
    notes: null,
    createdAt: date,
  );
}

ExpenseRecord _expense({required DateTime date, required int amount}) {
  return ExpenseRecord(
    id: 3,
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
  group('computeRecentActivities', () {
    test('merges all three record types sorted newest first', () {
      final activities = computeRecentActivities(
        maintenanceRecords: [
          _maintenance(date: DateTime(2026, 5, 10), cost: 5000000),
        ],
        fuelRecords: [_fuel(date: DateTime(2026, 5, 20), totalCost: 1500000)],
        expenseRecords: [
          _expense(date: DateTime(2026, 5, 15), amount: 30000000),
        ],
      );

      expect(activities, hasLength(3));
      expect(activities[0].kind, ActivityKind.fuel); // May 20, newest
      expect(activities[1].kind, ActivityKind.expense); // May 15
      expect(activities[2].kind, ActivityKind.maintenance); // May 10, oldest
    });

    test('is empty with no records at all', () {
      final activities = computeRecentActivities(
        maintenanceRecords: const [],
        fuelRecords: const [],
        expenseRecords: const [],
      );
      expect(activities, isEmpty);
    });

    test('caps at the given limit, keeping only the most recent', () {
      final maintenanceRecords = [
        for (var day = 1; day <= 10; day++)
          _maintenance(date: DateTime(2026, 5, day), cost: 100),
      ];

      final activities = computeRecentActivities(
        maintenanceRecords: maintenanceRecords,
        fuelRecords: const [],
        expenseRecords: const [],
        limit: 3,
      );

      expect(activities, hasLength(3));
      expect(activities.map((a) => a.date), [
        DateTime(2026, 5, 10),
        DateTime(2026, 5, 9),
        DateTime(2026, 5, 8),
      ]);
    });

    test('maintenance title comes from the record, fuel gets a fixed label, '
        'expense uses its category label', () {
      final activities = computeRecentActivities(
        maintenanceRecords: [
          _maintenance(date: DateTime(2026, 5, 1), cost: 100),
        ],
        fuelRecords: [_fuel(date: DateTime(2026, 5, 2), totalCost: 200)],
        expenseRecords: [_expense(date: DateTime(2026, 5, 3), amount: 300)],
      );

      final byKind = {for (final a in activities) a.kind: a};
      expect(byKind[ActivityKind.maintenance]!.title, 'تعویض روغن موتور');
      expect(byKind[ActivityKind.fuel]!.title, 'سوخت‌گیری');
      expect(byKind[ActivityKind.expense]!.title, 'بیمه');
    });
  });
}
