import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'core/di/service_locator.dart';
import 'core/notifications/notification_service.dart';
import 'core/notifications/notification_scheduler.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_material_localizations.dart';
import 'features/settings/cubit/settings_cubit.dart';
import 'features/settings/cubit/settings_state.dart';
import 'features/settings/data/app_settings_repository.dart';
import 'features/vehicles/cubit/active_vehicle_cubit.dart';
import 'features/vehicles/data/vehicle_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  // Render the first frame immediately rather than blocking app launch on
  // notification setup + a possible permission-request dialog.
  runApp(const CarYarApp());
  _initNotifications();
}

Future<void> _initNotifications() async {
  try {
    await getIt<NotificationService>().init();
    // Notifications default to enabled (see AppSettings) — the Settings
    // screen lets the user turn this off, at which point
    // NotificationScheduler stops scheduling/cancels existing reminders, but
    // the OS permission itself is only ever requested here, once, and only
    // when the feature is actually on.
    //
    // A one-shot `getSettings()` read, not `watchSettings().first` — the
    // latter has repeatedly hung forever when another live subscriber already
    // exists on the same table (see khodroyar-build-constraints memory).
    final settings = await getIt<AppSettingsRepository>().getSettings();
    if (settings.notificationsEnabled) {
      await getIt<NotificationService>().requestPermission();
      await getIt<NotificationScheduler>().rescheduleAll();
    }
  } catch (error) {
    // Reminder availability must not prevent the offline app from launching.
    debugPrint('Notification initialization failed: $error');
  }
}

class CarYarApp extends StatelessWidget {
  const CarYarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ActiveVehicleCubit(getIt<VehicleRepository>())..watch(),
        ),
        BlocProvider(
          create: (_) => SettingsCubit(getIt<AppSettingsRepository>())..watch(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          final themeMode = switch (settingsState) {
            SettingsLoading() => ThemeMode.system,
            SettingsLoaded(:final themeMode) => themeMode.themeMode,
          };
          return MaterialApp.router(
            title: 'خودرویار پارسیک',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeMode,
            locale: const Locale('fa', 'IR'),
            supportedLocales: const [Locale('fa', 'IR')],
            localizationsDelegates: const [
              // Must come before the Global* delegates below — Flutter uses
              // the first delegate in the list that supports a given type,
              // and only PersianMaterialLocalizations knows Jalali month
              // names/labels for showPersianDatePicker (see pickJalaliDate).
              AppMaterialLocalizations.delegate,
              PersianCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
