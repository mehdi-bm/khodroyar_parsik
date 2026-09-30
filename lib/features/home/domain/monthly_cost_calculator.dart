import '../../../core/database/app_database.dart';
import '../../../core/utils/jalali_period.dart';

/// Sums every cost dated within [month]'s calendar month across all three
/// cost-bearing tables — maintenance, fuel, and standalone expenses. A cost
/// lives in exactly one of these tables (see the ExpenseRecords doc
/// comment), so summing all three never double-counts.
int computeMonthlyCost({
  required List<MaintenanceRecord> maintenanceRecords,
  required List<FuelRecord> fuelRecords,
  required List<ExpenseRecord> expenseRecords,
  required DateTime month,
}) {
  final period = JalaliPeriod.month(month);
  bool inMonth(DateTime date) =>
      !date.isBefore(period.start) && !date.isAfter(period.end);

  final maintenanceTotal = maintenanceRecords
      .where((r) => inMonth(r.date))
      .fold<int>(0, (sum, r) => sum + r.cost);
  final fuelTotal = fuelRecords
      .where((r) => inMonth(r.date))
      .fold<int>(0, (sum, r) => sum + r.totalCost);
  final expenseTotal = expenseRecords
      .where((r) => inMonth(r.date))
      .fold<int>(0, (sum, r) => sum + r.amount);

  return maintenanceTotal + fuelTotal + expenseTotal;
}
