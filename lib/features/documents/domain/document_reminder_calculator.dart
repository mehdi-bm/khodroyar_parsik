/// The reminder fire time for a document's [expirationDate], [reminderDaysBefore]
/// days ahead of expiry, at 09:00 local time.
DateTime computeDocumentReminderTime({
  required DateTime expirationDate,
  required int reminderDaysBefore,
}) {
  final reminderDate = expirationDate.subtract(
    Duration(days: reminderDaysBefore),
  );
  return DateTime(reminderDate.year, reminderDate.month, reminderDate.day, 9);
}
