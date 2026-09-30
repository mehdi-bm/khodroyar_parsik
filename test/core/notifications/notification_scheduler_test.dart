import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/core/notifications/notification_ids.dart';
import 'package:caryar/core/notifications/notification_scheduler.dart';

import '../../support/fake_notification_sink.dart';

void main() {
  late AppDatabase db;
  late FakeNotificationSink sink;
  late NotificationScheduler scheduler;

  setUp(() {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
    sink = FakeNotificationSink();
    scheduler = NotificationScheduler(db, sink);
  });

  tearDown(() async {
    await db.close();
  });

  MaintenanceSchedule maintenanceSchedule({
    int id = 1,
    int? intervalDays,
    DateTime? lastServiceDate,
  }) {
    final now = DateTime(2026, 1, 1);
    return MaintenanceSchedule(
      id: id,
      vehicleId: 1,
      title: 'روغن موتور',
      category: 'engineOil',
      intervalMileage: null,
      intervalDays: intervalDays,
      lastServiceMileage: null,
      lastServiceDate: lastServiceDate,
      createdAt: now,
      updatedAt: now,
    );
  }

  Document document({int id = 1, required DateTime expirationDate}) {
    return Document(
      id: id,
      vehicleId: 1,
      title: 'بیمه شخص ثالث',
      type: 'insurance',
      startDate: null,
      expirationDate: expirationDate,
      photoPath: null,
      notes: null,
      createdAt: DateTime(2026, 1, 1),
    );
  }

  group('scheduleForMaintenanceSchedule', () {
    test(
      'schedules a reminder when the schedule has a date dimension',
      () async {
        await scheduler.scheduleForMaintenanceSchedule(
          maintenanceSchedule(
            intervalDays: 180,
            lastServiceDate: DateTime(2026, 1, 1),
          ),
        );

        final id = NotificationIds.maintenanceScheduleDate(1);
        expect(sink.scheduled.containsKey(id), isTrue);
        expect(sink.scheduled[id]!.dateTime, DateTime(2026, 6, 23, 9));
      },
    );

    test(
      'cancels any existing reminder when there is no date dimension',
      () async {
        await scheduler.scheduleForMaintenanceSchedule(maintenanceSchedule());

        final id = NotificationIds.maintenanceScheduleDate(1);
        expect(sink.scheduled.containsKey(id), isFalse);
        expect(sink.cancelled, contains(id));
      },
    );

    test(
      'cancels instead of scheduling when notifications are disabled',
      () async {
        await db.appSettingsDao.updateSettings(
          const AppSettingsCompanion(notificationsEnabled: Value(false)),
        );

        await scheduler.scheduleForMaintenanceSchedule(
          maintenanceSchedule(
            intervalDays: 180,
            lastServiceDate: DateTime(2026, 1, 1),
          ),
        );

        final id = NotificationIds.maintenanceScheduleDate(1);
        expect(sink.scheduled.containsKey(id), isFalse);
        expect(sink.cancelled, contains(id));
      },
    );
  });

  group('scheduleForDocument', () {
    test('schedules using the configured documentReminderDaysBefore', () async {
      await db.appSettingsDao.updateSettings(
        const AppSettingsCompanion(documentReminderDaysBefore: Value(3)),
      );

      await scheduler.scheduleForDocument(
        document(expirationDate: DateTime(2026, 6, 1)),
      );

      final id = NotificationIds.document(1);
      expect(sink.scheduled[id]!.dateTime, DateTime(2026, 5, 29, 9));
    });
  });

  group('cancelForDocument', () {
    test('cancels the document notification', () async {
      await scheduler.scheduleForDocument(
        document(expirationDate: DateTime(2026, 6, 1)),
      );
      await scheduler.cancelForDocument(1);

      final id = NotificationIds.document(1);
      expect(sink.scheduled.containsKey(id), isFalse);
      expect(sink.cancelled, contains(id));
    });
  });

  group('checkMileageReminder', () {
    test(
      'shows an immediate notification once, not twice, in one session',
      () async {
        final schedule = MaintenanceSchedule(
          id: 1,
          vehicleId: 1,
          title: 'روغن موتور',
          category: 'engineOil',
          intervalMileage: 5000,
          intervalDays: null,
          lastServiceMileage: 80000,
          lastServiceDate: null,
          createdAt: DateTime(2026, 1, 1),
          updatedAt: DateTime(2026, 1, 1),
        );

        await scheduler.checkMileageReminder(
          schedule: schedule,
          currentMileage: 86000,
        );
        await scheduler.checkMileageReminder(
          schedule: schedule,
          currentMileage: 86000,
        );

        final id = NotificationIds.maintenanceScheduleMileage(1);
        expect(sink.shownNow.where((shown) => shown == id), hasLength(1));
      },
    );

    test('does nothing when notifications are disabled', () async {
      await db.appSettingsDao.updateSettings(
        const AppSettingsCompanion(notificationsEnabled: Value(false)),
      );
      final schedule = MaintenanceSchedule(
        id: 1,
        vehicleId: 1,
        title: 'روغن موتور',
        category: 'engineOil',
        intervalMileage: 5000,
        intervalDays: null,
        lastServiceMileage: 80000,
        lastServiceDate: null,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      );

      await scheduler.checkMileageReminder(
        schedule: schedule,
        currentMileage: 86000,
      );

      expect(sink.shownNow, isEmpty);
    });
  });

  group('cancelAll', () {
    test('delegates to the sink', () async {
      await scheduler.scheduleForDocument(
        document(expirationDate: DateTime(2026, 6, 1)),
      );
      expect(sink.scheduled, isNotEmpty);

      await scheduler.cancelAll();

      expect(sink.cancelledAll, isTrue);
      expect(sink.scheduled, isEmpty);
    });
  });
}
