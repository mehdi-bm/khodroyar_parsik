import '../../../core/utils/number_format.dart';
import '../../../core/widgets/status_badge.dart';

/// Unlike maintenance schedules, a document has no user-defined interval to
/// measure against — just a single expiration date — so these thresholds
/// are fixed, sensible windows (not invented manufacturer data, just UI
/// breakpoints) rather than a percentage of anything. Chosen to match the
/// spec's own dashboard examples: 84 days remaining reads as "upcoming"
/// (⚠), 120 days as "good" (🟢).
abstract final class _DocumentStatusThresholds {
  static const int dueDays = 14;
  static const int upcomingDays = 90;
}

int daysRemaining(DateTime expirationDate, DateTime today) {
  final todayDateOnly = DateTime(today.year, today.month, today.day);
  final expirationDateOnly = DateTime(
    expirationDate.year,
    expirationDate.month,
    expirationDate.day,
  );
  return expirationDateOnly.difference(todayDateOnly).inDays;
}

AppStatusLevel computeDocumentStatus({
  required DateTime expirationDate,
  required DateTime today,
}) {
  final remaining = daysRemaining(expirationDate, today);
  if (remaining <= 0) return AppStatusLevel.overdue;
  if (remaining <= _DocumentStatusThresholds.dueDays) return AppStatusLevel.due;
  if (remaining <= _DocumentStatusThresholds.upcomingDays) {
    return AppStatusLevel.upcoming;
  }
  return AppStatusLevel.good;
}

/// Persian remaining/expired text, e.g. "84 روز باقی‌مانده" or "3 روز
/// منقضی شده" — matching the spec's dashboard status-line examples.
String describeDocumentRemaining({
  required DateTime expirationDate,
  required DateTime today,
}) {
  final remaining = daysRemaining(expirationDate, today);
  return remaining <= 0
      ? '${formatNumber(-remaining)} روز منقضی شده'
      : '${formatNumber(remaining)} روز باقی‌مانده';
}
