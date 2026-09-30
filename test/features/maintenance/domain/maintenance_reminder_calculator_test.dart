import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/maintenance/domain/maintenance_reminder_calculator.dart';

MaintenanceSchedule _schedule({int? intervalDays, DateTime? lastServiceDate}) {
  final now = DateTime(2026, 1, 1);
  return MaintenanceSchedule(
    id: 1,
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

void main() {
  test('returns null when the schedule has no date dimension', () {
    final reminderTime = computeMaintenanceReminderTime(
      schedule: _schedule(),
      reminderDaysBefore: 7,
    );
    expect(reminderTime, isNull);
  });

  test(
    'fires reminderDaysBefore days ahead of the next service date, at 09:00',
    () {
      final schedule = _schedule(
        intervalDays: 180,
        lastServiceDate: DateTime(2026, 1, 1),
      );
      // Next service: 2026-06-30. 7 days before -> 2026-06-23 09:00.
      final reminderTime = computeMaintenanceReminderTime(
        schedule: schedule,
        reminderDaysBefore: 7,
      );
      expect(reminderTime, DateTime(2026, 6, 23, 9));
    },
  );
}
