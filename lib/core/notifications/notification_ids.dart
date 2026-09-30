/// Deterministic, non-overlapping notification ID ranges per record type,
/// so scheduling the same schedule/document again (an update) replaces the
/// previous notification instead of stacking a duplicate — satisfying the
/// spec's "avoid duplicate notifications" rule for free.
abstract final class NotificationIds {
  static int maintenanceScheduleDate(int scheduleId) => 100000 + scheduleId;
  static int document(int documentId) => 200000 + documentId;
  static int maintenanceScheduleMileage(int scheduleId) => 300000 + scheduleId;
}
