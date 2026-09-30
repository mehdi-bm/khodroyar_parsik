import '../../../core/database/app_database.dart';
import '../../../core/widgets/status_badge.dart';
import 'maintenance_status_calculator.dart';

/// Whether [schedule] should trigger an immediate mileage-based reminder
/// right now (section 51: "notify when remaining mileage reaches configured
/// threshold"). Only the mileage dimension is considered — the date
/// dimension, if also due, already has its own separately-scheduled OS
/// notification, so checking it here would double-notify for one issue.
///
/// This is a pure decision function; the caller (see
/// `NotificationService.hasShownThisSession`) is responsible for not
/// re-firing it on every check.
bool shouldNotifyForMileage({
  required MaintenanceSchedule schedule,
  required int currentMileage,
}) {
  final level = maintenanceMileageStatus(
    schedule: schedule,
    currentMileage: currentMileage,
  );
  return level == AppStatusLevel.due || level == AppStatusLevel.overdue;
}
