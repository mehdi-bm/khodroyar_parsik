import 'package:caryar/core/notifications/notification_sink.dart';

class ScheduledCall {
  ScheduledCall({
    required this.id,
    required this.title,
    required this.body,
    required this.dateTime,
  });
  final int id;
  final String title;
  final String body;
  final DateTime dateTime;
}

/// In-memory [NotificationSink] for tests — never touches a platform
/// channel (which would hang forever under plain `flutter test`, since
/// nothing ever answers it). Records every call so tests can assert on
/// scheduling *decisions* without a real notifications plugin.
class FakeNotificationSink implements NotificationSink {
  final Map<int, ScheduledCall> scheduled = {};
  final List<int> shownNow = [];
  final List<int> cancelled = [];
  bool cancelledAll = false;
  final Set<int> _shownThisSession = {};

  @override
  Future<void> scheduleAt({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    scheduled[id] = ScheduledCall(
      id: id,
      title: title,
      body: body,
      dateTime: dateTime,
    );
  }

  @override
  Future<void> showNow({
    required int id,
    required String title,
    required String body,
  }) async {
    shownNow.add(id);
  }

  @override
  Future<void> cancel(int id) async {
    scheduled.remove(id);
    cancelled.add(id);
  }

  @override
  Future<void> cancelAll() async {
    scheduled.clear();
    cancelledAll = true;
  }

  @override
  bool hasShownThisSession(int id) => _shownThisSession.contains(id);

  @override
  void markShownThisSession(int id) => _shownThisSession.add(id);
}
