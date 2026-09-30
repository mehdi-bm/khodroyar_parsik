import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/core/notifications/notification_ids.dart';
import 'package:caryar/core/notifications/notification_scheduler.dart';
import 'package:caryar/features/settings/data/app_settings_repository.dart';
import 'package:caryar/features/vehicles/data/vehicle_repository.dart';
import '../../support/fake_notification_sink.dart';

void main() {
  test(
    'changing reminder timing, disabling and enabling updates saved reminders',
    () async {
      final db = AppDatabase.withExecutor(NativeDatabase.memory());
      addTearDown(db.close);
      final sink = FakeNotificationSink();
      final scheduler = NotificationScheduler(db, sink);
      final settings = AppSettingsRepository(db.appSettingsDao, scheduler);
      final vehicleId = await db.vehicleDao.insertVehicle(
        const VehiclesCompanion(name: Value('پژو')),
      );
      final documentId = await db.documentDao.insertDocument(
        DocumentsCompanion.insert(
          vehicleId: vehicleId,
          title: 'بیمه',
          type: 'insurance',
          expirationDate: DateTime(2027, 5, 20),
        ),
      );
      await settings.setDocumentReminderDaysBefore(3);
      final id = NotificationIds.document(documentId);
      expect(sink.scheduled[id]!.dateTime, DateTime(2027, 5, 17, 9));
      await settings.setNotificationsEnabled(false);
      expect(sink.scheduled, isEmpty);
      await settings.setNotificationsEnabled(true);
      expect(sink.scheduled, contains(id));
      await VehicleRepository(db, scheduler).deleteVehicle(vehicleId);
      expect(sink.scheduled, isEmpty);
    },
  );
}
