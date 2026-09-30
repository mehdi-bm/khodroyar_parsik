import 'package:flutter/material.dart' show DateTimeRange;
import 'package:flutter_test/flutter_test.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/reports/domain/report_calculator.dart';

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

FuelRecord _fuel({
  required DateTime date,
  required int mileage,
  required double liters,
  required int totalCost,
  bool isFullTank = true,
}) {
  return FuelRecord(
    id: mileage,
    vehicleId: 1,
    date: date,
    mileage: mileage,
    fuelAmountLiters: liters,
    totalCost: totalCost,
    pricePerLiter: null,
    isFullTank: isFullTank,
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
  group('computeReportSummary', () {
    final period = DateTimeRange(
      start: DateTime(2026, 5, 1),
      end: DateTime(2026, 5, 31, 23, 59, 59),
    );

    test('sums each cost type only within the period', () {
      final summary = computeReportSummary(
        maintenanceRecords: [
          _maintenance(date: DateTime(2026, 5, 10), cost: 1500000),
          _maintenance(date: DateTime(2026, 4, 10), cost: 999),
        ],
        fuelRecords: [
          _fuel(
            date: DateTime(2026, 5, 15),
            mileage: 1,
            liters: 35,
            totalCost: 1225000,
          ),
        ],
        expenseRecords: [_expense(date: DateTime(2026, 5, 20), amount: 450000)],
        period: period,
      );

      expect(summary.maintenanceCost, 1500000);
      expect(summary.fuelCost, 1225000);
      expect(summary.otherExpenseCost, 450000);
      expect(summary.maintenanceCount, 1);
      expect(summary.totalCost, 1500000 + 1225000 + 450000);
    });

    test('is all zero with no records', () {
      final summary = computeReportSummary(
        maintenanceRecords: const [],
        fuelRecords: const [],
        expenseRecords: const [],
        period: period,
      );
      expect(summary.totalCost, 0);
      expect(summary.maintenanceCount, 0);
    });
  });

  group('computeMonthlyCostSeries', () {
    test('returns monthsBack points ending with the current month', () {
      final series = computeMonthlyCostSeries(
        maintenanceRecords: [
          _maintenance(date: DateTime(2026, 5, 10), cost: 1000000),
        ],
        fuelRecords: const [],
        expenseRecords: const [],
        now: DateTime(2026, 5, 15),
        monthsBack: 3,
      );

      expect(series, hasLength(3));
      expect(series.map((p) => Jalali.fromDateTime(p.month).month), [12, 1, 2]);
      expect(series.last.totalCost, 1000000);
      expect(series.first.totalCost, 0);
    });
  });

  group('computeFuelConsumptionSeries', () {
    test(
      'produces one point per computable full-tank fill-up, oldest first',
      () {
        final records = [
          _fuel(
            date: DateTime(2026, 1, 1),
            mileage: 80000,
            liters: 40,
            totalCost: 1400000,
          ),
          _fuel(
            date: DateTime(2026, 2, 1),
            mileage: 80500,
            liters: 37,
            totalCost: 1295000,
          ),
          _fuel(
            date: DateTime(2026, 2, 15),
            mileage: 80700,
            liters: 12,
            totalCost: 420000,
            isFullTank: false,
          ),
        ];

        final series = computeFuelConsumptionSeries(records);

        expect(series, hasLength(1));
        expect(series.single.litersPer100Km, closeTo(7.4, 0.0001));
      },
    );
  });
}
