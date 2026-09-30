import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/core/widgets/status_badge.dart';
import 'package:caryar/features/maintenance/domain/maintenance_status_calculator.dart';

MaintenanceSchedule _schedule({
  int? intervalMileage,
  int? intervalDays,
  int? lastServiceMileage,
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
  final today = DateTime(2026, 6, 1);

  group('computeMaintenanceStatus — mileage-only schedule', () {
    test('good when far from the next service', () {
      final schedule = _schedule(
        intervalMileage: 5000,
        lastServiceMileage: 80000,
      );
      final status = computeMaintenanceStatus(
        schedule: schedule,
        currentMileage: 81000, // 4000 remaining of 5000 (80%) — well above 25%
        today: today,
      );
      expect(status, AppStatusLevel.good);
    });

    test('upcoming within 25% of the interval remaining', () {
      final schedule = _schedule(
        intervalMileage: 5000,
        lastServiceMileage: 80000,
      );
      final status = computeMaintenanceStatus(
        schedule: schedule,
        currentMileage: 83900, // 1100 remaining (22%)
        today: today,
      );
      expect(status, AppStatusLevel.upcoming);
    });

    test('due within 10% of the interval remaining', () {
      final schedule = _schedule(
        intervalMileage: 5000,
        lastServiceMileage: 80000,
      );
      final status = computeMaintenanceStatus(
        schedule: schedule,
        currentMileage: 84600, // 400 remaining (8%)
        today: today,
      );
      expect(status, AppStatusLevel.due);
    });

    test('overdue once past the next service mileage', () {
      final schedule = _schedule(
        intervalMileage: 5000,
        lastServiceMileage: 80000,
      );
      final status = computeMaintenanceStatus(
        schedule: schedule,
        currentMileage: 85001,
        today: today,
      );
      expect(status, AppStatusLevel.overdue);
    });
  });

  group('computeMaintenanceStatus — date-only schedule', () {
    test('overdue once past the next service date', () {
      final schedule = _schedule(
        intervalDays: 180,
        lastServiceDate: DateTime(2025, 10, 1),
      );
      final status = computeMaintenanceStatus(
        schedule: schedule,
        currentMileage: 0,
        today: DateTime(2026, 4, 1),
      );
      expect(status, AppStatusLevel.overdue);
    });
  });

  test('a schedule with neither interval nor baseline is treated as good', () {
    final status = computeMaintenanceStatus(
      schedule: _schedule(),
      currentMileage: 50000,
      today: today,
    );
    expect(status, AppStatusLevel.good);
  });

  test('combined schedule takes the worse of the two dimensions', () {
    final schedule = _schedule(
      intervalMileage: 5000,
      lastServiceMileage: 80000, // mileage: 4000 remaining -> good
      intervalDays: 180,
      lastServiceDate: DateTime(2025, 1, 1), // date: long overdue
    );
    final status = computeMaintenanceStatus(
      schedule: schedule,
      currentMileage: 81000,
      today: DateTime(2026, 6, 1),
    );
    expect(status, AppStatusLevel.overdue);
  });

  group('describeMaintenanceRemaining', () {
    test('describes remaining mileage', () {
      final schedule = _schedule(
        intervalMileage: 5000,
        lastServiceMileage: 80000,
      );
      final text = describeMaintenanceRemaining(
        schedule: schedule,
        currentMileage: 83800,
        today: today,
      );
      expect(text, '۱,۲۰۰ کیلومتر باقی‌مانده');
    });

    test('describes overdue mileage as "عقب‌افتاده"', () {
      final schedule = _schedule(
        intervalMileage: 5000,
        lastServiceMileage: 80000,
      );
      final text = describeMaintenanceRemaining(
        schedule: schedule,
        currentMileage: 85300,
        today: today,
      );
      expect(text, '۳۰۰ کیلومتر عقب‌افتاده');
    });

    test('describes remaining days when only a date rule exists', () {
      final schedule = _schedule(
        intervalDays: 180,
        lastServiceDate: DateTime(2026, 1, 1),
      );
      final text = describeMaintenanceRemaining(
        schedule: schedule,
        currentMileage: 0,
        today: DateTime(2026, 6, 1),
      );
      // 2026-01-01 + 180 days = 2026-06-30; 29 days after 2026-06-01.
      expect(text, '۲۹ روز باقی‌مانده');
    });

    test('picks the more urgent dimension when both exist', () {
      final schedule = _schedule(
        intervalMileage: 5000,
        lastServiceMileage: 80000, // good
        intervalDays: 180,
        lastServiceDate: DateTime(2025, 1, 1), // overdue
      );
      final text = describeMaintenanceRemaining(
        schedule: schedule,
        currentMileage: 81000,
        today: DateTime(2026, 6, 1),
      );
      expect(text, contains('روز عقب‌افتاده'));
    });

    test('reports insufficient data when neither rule is computable', () {
      final text = describeMaintenanceRemaining(
        schedule: _schedule(),
        currentMileage: 50000,
        today: today,
      );
      expect(text, 'اطلاعات کافی برای محاسبه موجود نیست');
    });
  });
}
