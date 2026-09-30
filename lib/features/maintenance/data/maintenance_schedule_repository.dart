import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/notifications/notification_scheduler.dart';

/// Recurring service rules, one per vehicle+category. A schedule is never
/// created directly by the user in this phase — it's derived automatically
/// whenever a [MaintenanceRecord] is logged with a "next service" hint (see
/// [upsertFromRecord]), which is how the master spec's per-record
/// nextServiceMileage/nextServiceDate fields turn into ongoing tracking.
class MaintenanceScheduleRepository {
  MaintenanceScheduleRepository(this._db, [this._notificationScheduler]);

  final AppDatabase _db;

  /// Nullable so plain repository tests don't need a real notification
  /// stack — only the app's real service_locator wiring provides one.
  final NotificationScheduler? _notificationScheduler;

  Stream<List<MaintenanceSchedule>> watchForVehicle(int vehicleId) =>
      _db.maintenanceScheduleDao.watchForVehicle(vehicleId);

  Future<void> upsertFromRecord({
    required int vehicleId,
    required String category,
    required String title,
    required int serviceMileage,
    required DateTime serviceDate,
    int? nextServiceMileage,
    DateTime? nextServiceDate,
  }) async {
    if (nextServiceMileage == null && nextServiceDate == null) return;

    final intervalMileage = nextServiceMileage != null
        ? nextServiceMileage - serviceMileage
        : null;
    final intervalDays = nextServiceDate?.difference(serviceDate).inDays;

    final existing = await _db.maintenanceScheduleDao.getForVehicleAndCategory(
      vehicleId,
      category,
    );

    final int scheduleId;
    if (existing == null) {
      scheduleId = await _db.maintenanceScheduleDao.insertSchedule(
        MaintenanceSchedulesCompanion.insert(
          vehicleId: vehicleId,
          title: title,
          category: category,
          intervalMileage: Value(intervalMileage),
          intervalDays: Value(intervalDays),
          lastServiceMileage: Value(serviceMileage),
          lastServiceDate: Value(serviceDate),
        ),
      );
    } else {
      scheduleId = existing.id;
      await _db.maintenanceScheduleDao.updateSchedule(
        MaintenanceSchedulesCompanion(
          id: Value(existing.id),
          vehicleId: Value(vehicleId),
          category: Value(category),
          title: Value(title),
          intervalMileage: Value(intervalMileage ?? existing.intervalMileage),
          intervalDays: Value(intervalDays ?? existing.intervalDays),
          lastServiceMileage: Value(serviceMileage),
          lastServiceDate: Value(serviceDate),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }

    if (_notificationScheduler != null) {
      final saved = await _db.maintenanceScheduleDao.getById(scheduleId);
      if (saved != null) {
        await _notificationScheduler.scheduleForMaintenanceSchedule(saved);
      }
    }
  }
}
