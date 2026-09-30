import '../../../core/database/app_database.dart';
import '../../../core/utils/number_format.dart';
import '../../expenses/domain/expense_category.dart';

enum TimelineEntryKind { maintenance, fuel, expense, document }

/// One row in the full vehicle history timeline — unlike the dashboard's
/// "آخرین فعالیت‌ها" feed (see [computeRecentActivities]), this includes
/// documents and is never capped to a limit; it's meant to be the complete
/// record of everything logged for a vehicle.
class TimelineEntry {
  const TimelineEntry({
    required this.kind,
    required this.recordId,
    required this.date,
    required this.title,
    required this.subtitle,
    this.amount,
  });

  final TimelineEntryKind kind;
  final int recordId;
  final DateTime date;
  final String title;
  final String subtitle;

  /// `null` for documents, which aren't a cost event.
  final int? amount;
}

/// Merges every record type into one feed sorted by date, newest first.
/// Documents are keyed by [Document.createdAt] (when the user logged it),
/// not [Document.expirationDate] — the timeline reflects when things
/// happened, not when they're due.
List<TimelineEntry> computeTimeline({
  required List<MaintenanceRecord> maintenanceRecords,
  required List<FuelRecord> fuelRecords,
  required List<ExpenseRecord> expenseRecords,
  required List<Document> documents,
}) {
  final entries = <TimelineEntry>[
    for (final record in maintenanceRecords)
      TimelineEntry(
        kind: TimelineEntryKind.maintenance,
        recordId: record.id,
        date: record.date,
        title: record.title,
        subtitle: '${formatNumber(record.mileage)} کیلومتر',
        amount: record.cost,
      ),
    for (final record in fuelRecords)
      TimelineEntry(
        kind: TimelineEntryKind.fuel,
        recordId: record.id,
        date: record.date,
        title: 'سوخت‌گیری',
        subtitle:
            '${formatNumber(record.fuelAmountLiters)} لیتر  •  '
            '${formatNumber(record.mileage)} کیلومتر',
        amount: record.totalCost,
      ),
    for (final record in expenseRecords)
      TimelineEntry(
        kind: TimelineEntryKind.expense,
        recordId: record.id,
        date: record.date,
        title: ExpenseCategory.fromStorageKey(record.category).label,
        subtitle: record.description ?? '',
        amount: record.amount,
      ),
    for (final document in documents)
      TimelineEntry(
        kind: TimelineEntryKind.document,
        recordId: document.id,
        date: document.createdAt,
        title: document.title,
        subtitle: 'مدرک ثبت شد',
        amount: null,
      ),
  ];
  entries.sort((a, b) => b.date.compareTo(a.date));
  return entries;
}
