import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/core/notifications/notification_scheduler.dart';
import 'package:caryar/features/settings/data/app_settings_repository.dart';
import 'package:caryar/features/settings/domain/theme_mode_option.dart';

import '../../../support/fake_notification_sink.dart';

void main() {
  late AppDatabase db;
  late FakeNotificationSink sink;
  late AppSettingsRepository repository;

  setUp(() {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
    sink = FakeNotificationSink();
    repository = AppSettingsRepository(
      db.appSettingsDao,
      NotificationScheduler(db, sink),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('defaults to system theme and notifications enabled', () async {
    final settings = await repository.getSettings();
    expect(settings.themeMode, ThemeModeOption.system.storageKey);
    expect(settings.notificationsEnabled, isTrue);
  });

  test('setThemeMode persists the chosen option', () async {
    await repository.setThemeMode(ThemeModeOption.dark);
    final settings = await repository.getSettings();
    expect(settings.themeMode, ThemeModeOption.dark.storageKey);
  });

  test(
    'disabling notifications cancels everything already scheduled',
    () async {
      await sink.scheduleAt(
        id: 1,
        title: 'یادآوری',
        body: 'body',
        dateTime: DateTime.now().add(const Duration(days: 1)),
      );

      await repository.setNotificationsEnabled(false);

      final settings = await repository.getSettings();
      expect(settings.notificationsEnabled, isFalse);
      expect(sink.cancelledAll, isTrue);
      expect(sink.scheduled, isEmpty);
    },
  );

  test('re-enabling notifications refreshes existing schedules', () async {
    await repository.setNotificationsEnabled(false);
    sink.cancelledAll = false;

    await repository.setNotificationsEnabled(true);

    final settings = await repository.getSettings();
    expect(settings.notificationsEnabled, isTrue);
    expect(sink.cancelledAll, isTrue);
  });

  test('reminder day settings are stored independently', () async {
    await repository.setServiceReminderDaysBefore(3);
    await repository.setDocumentReminderDaysBefore(14);

    final settings = await repository.getSettings();
    expect(settings.serviceReminderDaysBefore, 3);
    expect(settings.documentReminderDaysBefore, 14);
  });
}
