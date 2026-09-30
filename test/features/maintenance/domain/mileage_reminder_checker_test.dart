import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/maintenance/domain/mileage_reminder_checker.dart';

MaintenanceSchedule _schedule({
  int? intervalMileage,
  int? lastServiceMileage,
  int? intervalDays,
  DateTime? lastServiceDate,
}) {
  final now = DateTime(2026, 1, 1);
  return MaintenanceSchedule(
    id: 1,
    vehicleId: 1,
    title: 'روغن موتور',
    category: 'engineOil',
    intervalMileage: intervalMileage,
    intervalDays: intervalDays,
    lastServiceMileage: lastServiceMileage,
    lastServiceDate: lastServiceDate,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  test('false when far from the next service', () {
    final schedule = _schedule(
      intervalMileage: 5000,
      lastServiceMileage: 80000,
    );
    expect(
      shouldNotifyForMileage(schedule: schedule, currentMileage: 81000),
      isFalse,
    );
  });

  test('true once within the due threshold', () {
    final schedule = _schedule(
      intervalMileage: 5000,
      lastServiceMileage: 80000,
    );
    expect(
      shouldNotifyForMileage(
        schedule: schedule,
        currentMileage: 84600,
      ), // 8% left
      isTrue,
    );
  });

  test('true once overdue', () {
    final schedule = _schedule(
      intervalMileage: 5000,
      lastServiceMileage: 80000,
    );
    expect(
      shouldNotifyForMileage(schedule: schedule, currentMileage: 86000),
      isTrue,
    );
  });

  test(
    'false when only the date dimension is due — that has its own scheduled notification',
    () {
      final schedule = _schedule(
        intervalDays: 180,
        lastServiceDate: DateTime(2025, 1, 1),
      );
      expect(
        shouldNotifyForMileage(schedule: schedule, currentMileage: 999999),
        isFalse,
      );
    },
  );

  test('false when the schedule has no mileage dimension at all', () {
    expect(
      shouldNotifyForMileage(schedule: _schedule(), currentMileage: 50000),
      isFalse,
    );
  });
}
