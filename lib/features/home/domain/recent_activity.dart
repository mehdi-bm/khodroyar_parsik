import '../../../core/database/app_database.dart';
import '../../expenses/domain/expense_category.dart';

enum ActivityKind { maintenance, fuel, expense }

/// One row in the dashboard's "آخرین فعالیت‌ها" feed — a maintenance, fuel,
/// or expense record reduced to what's needed to display and navigate to
/// it, never a separately-stored value.
class RecentActivity {
  const RecentActivity({
    required this.kind,
    required this.recordId,
    required this.date,
    required this.title,
    required this.amount,
  });

  final ActivityKind kind;
  final int recordId;
  final DateTime date;
  final String title;
  final int amount;
}

/// Merges the three cost-bearing record types into one feed sorted by date
/// (newest first), capped at [limit]. Documents are deliberately excluded —
/// they aren't a cost event the way the other three are, and were never
/// part of the dashboard's own quick-action trio either.
List<RecentActivity> computeRecentActivities({
  required List<MaintenanceRecord> maintenanceRecords,
  required List<FuelRecord> fuelRecords,
  required List<ExpenseRecord> expenseRecords,
  int limit = 5,
}) {
  final items = <RecentActivity>[
    for (final record in maintenanceRecords)
      RecentActivity(
        kind: ActivityKind.maintenance,
        recordId: record.id,
        date: record.date,
        title: record.title,
        amount: record.cost,
      ),
    for (final record in fuelRecords)
      RecentActivity(
        kind: ActivityKind.fuel,
        recordId: record.id,
        date: record.date,
        title: 'سوخت‌گیری',
        amount: record.totalCost,
      ),
    for (final record in expenseRecords)
      RecentActivity(
        kind: ActivityKind.expense,
        recordId: record.id,
        date: record.date,
        title: ExpenseCategory.fromStorageKey(record.category).label,
        amount: record.amount,
      ),
  ];
  items.sort((a, b) => b.date.compareTo(a.date));
  return items.take(limit).toList();
}
