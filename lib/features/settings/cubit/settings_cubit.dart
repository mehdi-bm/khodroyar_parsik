import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/app_settings_repository.dart';
import '../domain/theme_mode_option.dart';
import 'settings_state.dart';

/// App-wide: the single settings row, kept live so [main.dart]'s theme
/// mode reacts immediately to changes made from the Settings screen.
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository) : super(const SettingsLoading());

  final AppSettingsRepository _repository;
  StreamSubscription? _subscription;

  void watch() {
    _subscription?.cancel();
    _subscription = _repository.watchSettings().listen(
      (settings) => emit(SettingsLoaded(settings)),
    );
  }

  Future<void> setThemeMode(ThemeModeOption option) =>
      _repository.setThemeMode(option);

  Future<void> setNotificationsEnabled(bool enabled) =>
      _repository.setNotificationsEnabled(enabled);

  Future<void> setServiceReminderDaysBefore(int days) =>
      _repository.setServiceReminderDaysBefore(days);

  Future<void> setDocumentReminderDaysBefore(int days) =>
      _repository.setDocumentReminderDaysBefore(days);

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
