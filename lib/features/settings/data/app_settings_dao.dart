import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import 'app_settings_table.dart';

part 'app_settings_dao.g.dart';

const int kAppSettingsRowId = 0;

@DriftAccessor(tables: [AppSettings])
class AppSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$AppSettingsDaoMixin {
  AppSettingsDao(super.db);

  /// The single settings row, seeded by [AppDatabase]'s onCreate migration.
  Stream<AppSetting> watchSettings() => (select(
    appSettings,
  )..where((t) => t.id.equals(kAppSettingsRowId))).watchSingle();

  /// One-shot read for internal callers that just need the current values
  /// once (e.g. [NotificationScheduler]) — deliberately not `watchX().first`,
  /// which can hang when another live subscriber already exists on the
  /// same table (see khodroyar-build-constraints memory, Phase 10).
  Future<AppSetting> getSettings() => (select(
    appSettings,
  )..where((t) => t.id.equals(kAppSettingsRowId))).getSingle();

  Future<void> updateSettings(AppSettingsCompanion entry) async {
    await into(appSettings).insertOnConflictUpdate(
      entry.copyWith(id: const Value(kAppSettingsRowId)),
    );
  }
}
