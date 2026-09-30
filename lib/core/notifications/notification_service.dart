import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'notification_sink.dart';

const AndroidNotificationDetails _androidDetails = AndroidNotificationDetails(
  'vehicle_reminders',
  'یادآوری‌های خودرو',
  channelDescription: 'یادآوری سرویس و انقضای مدارک خودرو',
  importance: Importance.high,
  priority: Priority.high,
);

/// Wraps `flutter_local_notifications`. Works fully offline — reminders are
/// scheduled locally on-device, nothing goes over the network.
class NotificationService implements NotificationSink {
  NotificationService([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;
  Future<void>? _initializing;

  /// Session-scoped de-dup for the mileage-based reactive check (see
  /// `MileageReminderChecker`) — avoids re-firing the same immediate
  /// notification every time the dashboard rebuilds within one app run.
  /// Resets on app restart; deliberately not persisted (documented
  /// limitation — see khodroyar-build-constraints memory for the reasoning).
  final Set<int> _shownThisSession = {};

  Future<void> init() async {
    if (_initialized) return;
    if (_initializing != null) return _initializing;
    _initializing = _initialize();
    try {
      await _initializing;
    } finally {
      _initializing = null;
    }
  }

  Future<void> _initialize() async {
    tz_data.initializeTimeZones();
    // This app only targets Iranian users (see the product spec), so the
    // local timezone is hard-coded rather than pulling in a separate
    // device-timezone-lookup package for a single fixed value.
    tz.setLocalLocation(tz.getLocation('Asia/Tehran'));

    const androidInit = AndroidInitializationSettings('ic_stat_car');
    await _plugin.initialize(
      settings: const InitializationSettings(android: androidInit),
    );
    _initialized = true;
  }

  /// Only meaningful on Android — this app doesn't ship iOS/web targets.
  Future<bool> requestPermission() async {
    await init();
    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    return await androidImpl?.requestNotificationsPermission() ?? false;
  }

  @override
  Future<void> scheduleAt({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    await init();
    final scheduled = tz.TZDateTime.from(dateTime, tz.local);
    final now = tz.TZDateTime.now(tz.local);
    if (!scheduled.isAfter(now)) {
      // Already due (e.g. retroactively-entered data) — show it now
      // instead of asking the OS to schedule something in the past.
      await showNow(id: id, title: title, body: body);
      return;
    }
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: const NotificationDetails(android: _androidDetails),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  @override
  Future<void> showNow({
    required int id,
    required String title,
    required String body,
  }) async {
    await init();
    return _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(android: _androidDetails),
    );
  }

  @override
  Future<void> cancel(int id) => _plugin.cancel(id: id);

  @override
  Future<void> cancelAll() => _plugin.cancelAll();

  @override
  bool hasShownThisSession(int id) => _shownThisSession.contains(id);

  @override
  void markShownThisSession(int id) => _shownThisSession.add(id);
}
