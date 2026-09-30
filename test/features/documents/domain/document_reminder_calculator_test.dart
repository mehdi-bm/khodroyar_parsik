import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/documents/domain/document_reminder_calculator.dart';

void main() {
  test('fires reminderDaysBefore days ahead of expiration, at 09:00', () {
    final reminderTime = computeDocumentReminderTime(
      expirationDate: DateTime(2026, 6, 1),
      reminderDaysBefore: 7,
    );
    expect(reminderTime, DateTime(2026, 5, 25, 9));
  });

  test('can land before "now" for a near-term expiration', () {
    final reminderTime = computeDocumentReminderTime(
      expirationDate: DateTime(2026, 1, 3),
      reminderDaysBefore: 7,
    );
    expect(reminderTime, DateTime(2025, 12, 27, 9));
  });
}
