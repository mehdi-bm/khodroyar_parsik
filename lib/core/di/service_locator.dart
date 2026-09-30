import 'package:get_it/get_it.dart';

import '../../features/advertising/data/ads_config.dart';
import '../../features/advertising/data/advertising_gateway.dart';
import '../../features/advertising/data/advertising_service.dart';
import '../../features/advertising/data/app_support_gateway.dart';
import '../../features/advertising/data/app_support_service.dart';
import '../../features/advertising/data/install_id_repository.dart';
import '../../features/documents/data/document_repository.dart';
import '../../features/expenses/data/expense_repository.dart';
import '../../features/fuel/data/fuel_repository.dart';
import '../../features/maintenance/data/maintenance_repository.dart';
import '../../features/maintenance/data/maintenance_schedule_repository.dart';
import '../../features/parking/data/location_provider.dart';
import '../../features/parking/data/parking_repository.dart';
import '../../features/settings/data/app_settings_repository.dart';
import '../../features/settings/data/backup_service.dart';
import '../../features/vehicles/data/vehicle_repository.dart';
import '../database/app_database.dart';
import '../notifications/notification_scheduler.dart';
import '../notifications/notification_service.dart';
import '../notifications/notification_sink.dart';

final GetIt getIt = GetIt.instance;

/// Registers every app-wide singleton. [createDatabase] and
/// [createNotificationSink] are overridable so tests can swap in an
/// in-memory database and a fake notification sink and get every
/// repository wired up correctly without hand-mirroring each registration
/// — see test/widget_test.dart. Without an override, [NotificationSink]
/// resolves to the real [NotificationService] (a real platform-channel
/// call inside a plain `flutter test` run hangs forever rather than
/// throwing, since nothing ever answers it — tests must never resolve to
/// the real one).
void setupServiceLocator({
  AppDatabase Function()? createDatabase,
  NotificationSink Function()? createNotificationSink,
}) {
  getIt.registerLazySingleton<AppDatabase>(createDatabase ?? AppDatabase.new);
  getIt.registerLazySingleton<NotificationService>(NotificationService.new);
  getIt.registerLazySingleton<NotificationSink>(
    createNotificationSink ?? () => getIt<NotificationService>(),
  );
  getIt.registerLazySingleton<NotificationScheduler>(
    () =>
        NotificationScheduler(getIt<AppDatabase>(), getIt<NotificationSink>()),
  );
  getIt.registerLazySingleton<VehicleRepository>(
    () =>
        VehicleRepository(getIt<AppDatabase>(), getIt<NotificationScheduler>()),
  );
  getIt.registerLazySingleton<MaintenanceRepository>(
    () => MaintenanceRepository(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<MaintenanceScheduleRepository>(
    () => MaintenanceScheduleRepository(
      getIt<AppDatabase>(),
      getIt<NotificationScheduler>(),
    ),
  );
  getIt.registerLazySingleton<FuelRepository>(
    () => FuelRepository(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepository(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<DocumentRepository>(
    () => DocumentRepository(
      getIt<AppDatabase>(),
      getIt<NotificationScheduler>(),
    ),
  );
  getIt.registerLazySingleton<AppSettingsRepository>(
    () => AppSettingsRepository(
      getIt<AppDatabase>().appSettingsDao,
      getIt<NotificationScheduler>(),
    ),
  );
  getIt.registerLazySingleton<BackupService>(
    () => BackupService(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<AdsConfig>(AdsConfig.fromEnvironment);
  getIt.registerLazySingleton<AdvertisingGateway>(
    () => AdvertisingService(getIt<AdsConfig>()),
  );
  getIt.registerLazySingleton<AppSupportGateway>(
    () => AppSupportService(getIt<AdsConfig>()),
  );
  getIt.registerLazySingleton<InstallIdRepository>(InstallIdRepository.new);
  getIt.registerLazySingleton<ParkingRepository>(
    () => ParkingRepository(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<LocationProvider>(
    GeolocatorLocationProvider.new,
  );
}
