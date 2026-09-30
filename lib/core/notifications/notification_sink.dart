/// The minimal set of notification operations the rest of the app depends
/// on. [NotificationService] implements this against the real
/// `flutter_local_notifications` plugin; tests use a fake implementation to
/// verify scheduling *decisions* without touching platform channels.
abstract class NotificationSink {
  Future<void> scheduleAt({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  });

  Future<void> showNow({
    required int id,
    required String title,
    required String body,
  });

  Future<void> cancel(int id);

  /// Cancels every notification this app has scheduled or shown, regardless
  /// of id — used when the user turns notifications off entirely, so no
  /// stale reminder fires after the fact.
  Future<void> cancelAll();

  /// Session-scoped de-dup for reactive (non-scheduled) notifications like
  /// the mileage-based reminder — see NotificationService's doc comment for
  /// why this isn't persisted across app restarts.
  bool hasShownThisSession(int id);
  void markShownThisSession(int id);
}
