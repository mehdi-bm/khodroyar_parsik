import '../../../core/database/app_database.dart';

/// The date-based reminder fire time for [schedule]'s next service, or
/// `null` if the schedule has no date dimension. Fires at 09:00 local time,
/// [reminderDaysBefore] days ahead of the computed next-service date — the
/// notification content itself always says "service due", never a
/// fabricated remaining-time figure (per the app's rule against storing/
/// showing derived values that could go stale).
DateTime? computeMaintenanceReminderTime({
  required MaintenanceSchedule schedule,
  required int reminderDaysBefore,
}) {
  final interval = schedule.intervalDays;
  final last = schedule.lastServiceDate;
  if (interval == null || last == null) return null;

  final nextServiceDate = last.add(Duration(days: interval));
  final reminderDate = nextServiceDate.subtract(
    Duration(days: reminderDaysBefore),
  );
  return DateTime(reminderDate.year, reminderDate.month, reminderDate.day, 9);
}
