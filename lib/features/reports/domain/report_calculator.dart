import 'package:flutter/material.dart' show DateTimeRange;

import '../../../core/database/app_database.dart';
import '../../../core/utils/jalali_period.dart';
import '../../fuel/domain/fuel_consumption_calculator.dart';
import '../../home/domain/monthly_cost_calculator.dart';

/// Cost/count totals for one period — the spec's "monthly/yearly expense,
/// fuel, maintenance, other costs" report items (sections 14/18).
class ReportSummary {
  const ReportSummary({
    required this.maintenanceCost,
    required this.fuelCost,
    required this.otherExpenseCost,
    required this.maintenanceCount,
  });

  final int maintenanceCost;
  final int fuelCost;
  final int otherExpenseCost;
  final int maintenanceCount;

  int get totalCost => maintenanceCost + fuelCost + otherExpenseCost;
}

bool _inRange(DateTime date, DateTimeRange range) =>
    !date.isBefore(range.start) && !date.isAfter(range.end);

ReportSummary computeReportSummary({
  required List<MaintenanceRecord> maintenanceRecords,
  required List<FuelRecord> fuelRecords,
  required List<ExpenseRecord> expenseRecords,
  required DateTimeRange period,
}) {
  final maintenanceInRange = maintenanceRecords.where(
    (r) => _inRange(r.date, period),
  );
  final fuelInRange = fuelRecords.where((r) => _inRange(r.date, period));
  final expenseInRange = expenseRecords.where((r) => _inRange(r.date, period));

  return ReportSummary(
    maintenanceCost: maintenanceInRange.fold(0, (sum, r) => sum + r.cost),
    fuelCost: fuelInRange.fold(0, (sum, r) => sum + r.totalCost),
    otherExpenseCost: expenseInRange.fold(0, (sum, r) => sum + r.amount),
    maintenanceCount: maintenanceInRange.length,
  );
}

/// One bar of the monthly-cost chart.
class MonthlyCostPoint {
  const MonthlyCostPoint({required this.month, required this.totalCost});
  final DateTime month;
  final int totalCost;
}

/// The last [monthsBack] months (oldest first, ending with the current
/// month), reusing the same monthly-total logic as the dashboard's "هزینه
/// این ماه" card so the two never disagree.
List<MonthlyCostPoint> computeMonthlyCostSeries({
  required List<MaintenanceRecord> maintenanceRecords,
  required List<FuelRecord> fuelRecords,
  required List<ExpenseRecord> expenseRecords,
  required DateTime now,
  int monthsBack = 6,
}) {
  return [
    for (var i = monthsBack - 1; i >= 0; i--)
      _monthlyCostPointFor(
        month: JalaliPeriod.monthStart(now, offset: -i),
        maintenanceRecords: maintenanceRecords,
        fuelRecords: fuelRecords,
        expenseRecords: expenseRecords,
      ),
  ];
}

MonthlyCostPoint _monthlyCostPointFor({
  required DateTime month,
  required List<MaintenanceRecord> maintenanceRecords,
  required List<FuelRecord> fuelRecords,
  required List<ExpenseRecord> expenseRecords,
}) {
  final total = computeMonthlyCost(
    maintenanceRecords: maintenanceRecords,
    fuelRecords: fuelRecords,
    expenseRecords: expenseRecords,
    month: month,
  );
  return MonthlyCostPoint(month: month, totalCost: total);
}

/// One point of the fuel-consumption trend chart.
class FuelConsumptionPoint {
  const FuelConsumptionPoint({
    required this.date,
    required this.litersPer100Km,
  });
  final DateTime date;
  final double litersPer100Km;
}

/// Every computable consumption figure across [records] (oldest first) —
/// reuses [consumptionAt] from the fuel feature so the trend chart and the
/// dashboard's "مصرف سوخت اخیر" card use identical math.
List<FuelConsumptionPoint> computeFuelConsumptionSeries(
  List<FuelRecord> records,
) {
  final sorted = [...records]..sort((a, b) => a.mileage.compareTo(b.mileage));
  return [
    for (final record in sorted)
      if (consumptionAt(records, record) case final consumption?)
        FuelConsumptionPoint(date: record.date, litersPer100Km: consumption),
  ];
}
