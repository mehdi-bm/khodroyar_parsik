import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/notifications/notification_scheduler.dart';
import '../domain/theme_mode_option.dart';
import 'app_settings_dao.dart';

/// Wraps [AppSettingsDao] with the app's actual settings vocabulary
/// ([ThemeModeOption], day counts, ...) instead of raw DB columns, and
/// coordinates the one cross-cutting effect settings changes have: turning
/// notifications off must cancel every already-scheduled reminder, not just
/// stop scheduling new ones.
class AppSettingsRepository {
  AppSettingsRepository(this._dao, this._scheduler);

  final AppSettingsDao _dao;
  final NotificationScheduler _scheduler;

  Stream<AppSetting> watchSettings() => _dao.watchSettings();

  /// One-shot read — deliberately not `watchSettings().first`, which can
  /// hang when another live subscriber already exists on the same table
  /// (see khodroyar-build-constraints memory, Phase 10 and 13).
  Future<AppSetting> getSettings() => _dao.getSettings();

  Future<void> setThemeMode(ThemeModeOption option) {
    return _dao.updateSettings(
      AppSettingsCompanion(themeMode: Value(option.storageKey)),
    );
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    await _dao.updateSettings(
      AppSettingsCompanion(notificationsEnabled: Value(enabled)),
    );
    await _scheduler.rescheduleAll();
  }

  Future<void> setServiceReminderDaysBefore(int days) async {
    await _dao.updateSettings(
      AppSettingsCompanion(serviceReminderDaysBefore: Value(days)),
    );
    await _scheduler.rescheduleAll();
  }

  Future<void> setDocumentReminderDaysBefore(int days) async {
    await _dao.updateSettings(
      AppSettingsCompanion(documentReminderDaysBefore: Value(days)),
    );
    await _scheduler.rescheduleAll();
  }
}
