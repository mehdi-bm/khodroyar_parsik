import 'package:flutter/foundation.dart';

import '../../features/documents/domain/document_reminder_calculator.dart';
import '../../features/maintenance/domain/maintenance_reminder_calculator.dart';
import '../../features/maintenance/domain/mileage_reminder_checker.dart';
import '../database/app_database.dart';
import 'notification_ids.dart';
import 'notification_sink.dart';

/// Turns DB state + the user's notification settings into actual
/// schedule/cancel/show calls on a [NotificationSink]. This is the only
/// place that reads [AppDatabase]'s settings row for notification purposes
/// — repositories and UI code call through here instead of touching
/// [NotificationSink] directly, so "notifications disabled" and "no date
/// dimension" are handled uniformly in one spot.
///
/// Every public method swallows its own errors: a notification failing to
/// schedule (missing permission, platform channel not ready, ...) must
/// never break the record save it's attached to.
class NotificationScheduler {
  NotificationScheduler(this._db, this._sink);

  final AppDatabase _db;
  final NotificationSink _sink;
  Future<void> _rescheduleQueue = Future.value();

  /// Serialize changes so a fast sequence of settings edits cannot leave
  /// reminders scheduled using stale preferences.
  Future<void> rescheduleAll() {
    _rescheduleQueue = _rescheduleQueue.then((_) async {
      try {
        await _sink.cancelAll();
        if (!(await _currentSettings()).notificationsEnabled) return;
        final schedules = await _db.select(_db.maintenanceSchedules).get();
        final documents = await _db.select(_db.documents).get();
        for (final schedule in schedules) {
          await scheduleForMaintenanceSchedule(schedule);
        }
        for (final document in documents) {
          await scheduleForDocument(document);
        }
      } catch (error, stackTrace) {
        _logError('rescheduleAll', error, stackTrace);
      }
    });
    return _rescheduleQueue;
  }

  Future<void> scheduleForMaintenanceSchedule(
    MaintenanceSchedule schedule,
  ) async {
    try {
      final id = NotificationIds.maintenanceScheduleDate(schedule.id);
      final settings = await _currentSettings();
      if (!settings.notificationsEnabled) {
        await _sink.cancel(id);
        return;
      }

      final reminderTime = computeMaintenanceReminderTime(
        schedule: schedule,
        reminderDaysBefore: settings.serviceReminderDaysBefore,
      );
      if (reminderTime == null) {
        await _sink.cancel(id);
        return;
      }

      await _sink.scheduleAt(
        id: id,
        title: 'یادآوری سرویس خودرو',
        body: '${schedule.title} به موعد سرویس نزدیک است.',
        dateTime: reminderTime,
      );
    } catch (error, stackTrace) {
      _logError('scheduleForMaintenanceSchedule', error, stackTrace);
    }
  }

  Future<void> scheduleForDocument(Document document) async {
    try {
      final id = NotificationIds.document(document.id);
      final settings = await _currentSettings();
      if (!settings.notificationsEnabled) {
        await _sink.cancel(id);
        return;
      }

      final reminderTime = computeDocumentReminderTime(
        expirationDate: document.expirationDate,
        reminderDaysBefore: settings.documentReminderDaysBefore,
      );
      await _sink.scheduleAt(
        id: id,
        title: 'یادآوری انقضای مدرک',
        body: '${document.title} در حال انقضا است.',
        dateTime: reminderTime,
      );
    } catch (error, stackTrace) {
      _logError('scheduleForDocument', error, stackTrace);
    }
  }

  Future<void> cancelForDocument(int documentId) async {
    try {
      await _sink.cancel(NotificationIds.document(documentId));
    } catch (error, stackTrace) {
      _logError('cancelForDocument', error, stackTrace);
    }
  }

  /// The reactive mileage-based check (section 51) — call whenever the
  /// active vehicle's current mileage is known and up to date (currently:
  /// from the dashboard). Fires at most once per app session per schedule.
  Future<void> checkMileageReminder({
    required MaintenanceSchedule schedule,
    required int currentMileage,
  }) async {
    try {
      final settings = await _currentSettings();
      if (!settings.notificationsEnabled) return;
      if (!shouldNotifyForMileage(
        schedule: schedule,
        currentMileage: currentMileage,
      )) {
        return;
      }

      final id = NotificationIds.maintenanceScheduleMileage(schedule.id);
      if (_sink.hasShownThisSession(id)) return;

      await _sink.showNow(
        id: id,
        title: 'یادآوری سرویس خودرو',
        body: '${schedule.title} به موعد سرویس نزدیک است.',
      );
      _sink.markShownThisSession(id);
    } catch (error, stackTrace) {
      _logError('checkMileageReminder', error, stackTrace);
    }
  }

  /// Cancels every reminder this app has scheduled or shown, regardless of
  /// which record it belongs to — called when the user turns notifications
  /// off entirely (see [AppSettingsRepository.setNotificationsEnabled]).
  /// Re-enabling does not re-schedule anything retroactively: the next time
  /// each record's own save path runs, it naturally re-syncs its own
  /// reminder, and doing a full DB sweep on toggle-on is out of scope.
  Future<void> cancelAll() async {
    try {
      await _sink.cancelAll();
    } catch (error, stackTrace) {
      _logError('cancelAll', error, stackTrace);
    }
  }

  Future<AppSetting> _currentSettings() => _db.appSettingsDao.getSettings();

  void _logError(String where, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint('NotificationScheduler.$where failed: $error\n$stackTrace');
    }
  }
}
