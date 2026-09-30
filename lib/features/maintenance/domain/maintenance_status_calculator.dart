import '../../../core/database/app_database.dart';
import '../../../core/utils/number_format.dart';
import '../../../core/widgets/status_badge.dart';

/// How close to the interval's end "due" and "upcoming" kick in, as a
/// fraction of the schedule's own interval — not a hard-coded manufacturer
/// number, since the user defines their own intervals (per the app's rule
/// against inventing service data).
abstract final class _StatusThresholds {
  static const double due = 0.1;
  static const double upcoming = 0.25;
}

const List<AppStatusLevel> _severityOrder = [
  AppStatusLevel.good,
  AppStatusLevel.upcoming,
  AppStatusLevel.due,
  AppStatusLevel.overdue,
];

/// Combines the mileage-based and date-based rules on [schedule] (a
/// schedule may have either, or both — see section 8 of the spec) into a
/// single status, always taking the more urgent of the two when both apply.
/// Returns [AppStatusLevel.good] when the schedule has no computable rule
/// yet (missing both an interval and its baseline).
AppStatusLevel computeMaintenanceStatus({
  required MaintenanceSchedule schedule,
  required int currentMileage,
  required DateTime today,
}) {
  final levels = [
    _mileageLevel(schedule, currentMileage),
    _dateLevel(schedule, today),
  ].whereType<AppStatusLevel>();

  if (levels.isEmpty) return AppStatusLevel.good;
  return levels.reduce(
    (a, b) => _severityOrder.indexOf(a) >= _severityOrder.indexOf(b) ? a : b,
  );
}

/// A short Persian description of the schedule's most urgent dimension,
/// e.g. "1,200 کیلومتر باقی‌مانده" or "3 روز عقب‌افتاده" — matching the
/// dashboard status-line examples in the spec.
String describeMaintenanceRemaining({
  required MaintenanceSchedule schedule,
  required int currentMileage,
  required DateTime today,
}) {
  final mileageLevel = _mileageLevel(schedule, currentMileage);
  final dateLevel = _dateLevel(schedule, today);

  final useMileage =
      mileageLevel != null &&
      (dateLevel == null ||
          _severityOrder.indexOf(mileageLevel) >=
              _severityOrder.indexOf(dateLevel));

  if (useMileage) {
    final remaining = _remainingMileage(schedule, currentMileage)!;
    return remaining <= 0
        ? '${formatNumber(-remaining)} کیلومتر عقب‌افتاده'
        : '${formatNumber(remaining)} کیلومتر باقی‌مانده';
  }
  if (dateLevel != null) {
    final remaining = _remainingDays(schedule, today)!;
    return remaining <= 0
        ? '${formatNumber(-remaining)} روز عقب‌افتاده'
        : '${formatNumber(remaining)} روز باقی‌مانده';
  }
  return 'اطلاعات کافی برای محاسبه موجود نیست';
}

/// The mileage-only status dimension, ignoring the date dimension — used by
/// the mileage-based reminder notification check, which must fire only
/// when the mileage side specifically is due/overdue (the date side, if
/// also due, already has its own separately-scheduled notification).
AppStatusLevel? maintenanceMileageStatus({
  required MaintenanceSchedule schedule,
  required int currentMileage,
}) => _mileageLevel(schedule, currentMileage);

int? _remainingMileage(MaintenanceSchedule schedule, int currentMileage) {
  final interval = schedule.intervalMileage;
  final last = schedule.lastServiceMileage;
  if (interval == null || interval <= 0 || last == null) return null;
  return (last + interval) - currentMileage;
}

int? _remainingDays(MaintenanceSchedule schedule, DateTime today) {
  final interval = schedule.intervalDays;
  final last = schedule.lastServiceDate;
  if (interval == null || interval <= 0 || last == null) return null;
  final nextDate = last.add(Duration(days: interval));
  final todayDateOnly = DateTime(today.year, today.month, today.day);
  final nextDateOnly = DateTime(nextDate.year, nextDate.month, nextDate.day);
  return nextDateOnly.difference(todayDateOnly).inDays;
}

AppStatusLevel? _mileageLevel(
  MaintenanceSchedule schedule,
  int currentMileage,
) {
  final remaining = _remainingMileage(schedule, currentMileage);
  if (remaining == null) return null;
  return _levelForRemaining(remaining, schedule.intervalMileage!);
}

AppStatusLevel? _dateLevel(MaintenanceSchedule schedule, DateTime today) {
  final remaining = _remainingDays(schedule, today);
  if (remaining == null) return null;
  return _levelForRemaining(remaining, schedule.intervalDays!);
}

AppStatusLevel _levelForRemaining(num remaining, num interval) {
  if (remaining <= 0) return AppStatusLevel.overdue;
  if (remaining <= interval * _StatusThresholds.due) return AppStatusLevel.due;
  if (remaining <= interval * _StatusThresholds.upcoming) {
    return AppStatusLevel.upcoming;
  }
  return AppStatusLevel.good;
}
