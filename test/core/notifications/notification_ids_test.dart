import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/notifications/notification_ids.dart';

void main() {
  test(
    're-computing an ID for the same record is stable (enables update-in-place)',
    () {
      expect(
        NotificationIds.maintenanceScheduleDate(7),
        NotificationIds.maintenanceScheduleDate(7),
      );
    },
  );

  test('the three ID ranges never collide for any plausible record id', () {
    final dateIds = {
      for (var i = 1; i <= 1000; i++)
        NotificationIds.maintenanceScheduleDate(i),
    };
    final documentIds = {
      for (var i = 1; i <= 1000; i++) NotificationIds.document(i),
    };
    final mileageIds = {
      for (var i = 1; i <= 1000; i++)
        NotificationIds.maintenanceScheduleMileage(i),
    };

    expect(dateIds.intersection(documentIds), isEmpty);
    expect(dateIds.intersection(mileageIds), isEmpty);
    expect(documentIds.intersection(mileageIds), isEmpty);
  });
}
