import '../../../core/database/app_database.dart';
import '../domain/theme_mode_option.dart';

sealed class SettingsState {
  const SettingsState();
}

class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded(this.settings);

  final AppSetting settings;

  ThemeModeOption get themeMode =>
      ThemeModeOption.fromStorageKey(settings.themeMode);
}
