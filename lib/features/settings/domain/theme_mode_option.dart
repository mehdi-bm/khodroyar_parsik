import 'package:flutter/material.dart' show ThemeMode;

/// The three appearance choices from the spec (section 19). Stored in the
/// DB as [storageKey] (a plain string, not Flutter's own [ThemeMode] enum,
/// so the schema doesn't depend on a Flutter type).
enum ThemeModeOption {
  light,
  dark,
  system;

  String get label => switch (this) {
    ThemeModeOption.light => 'روشن',
    ThemeModeOption.dark => 'تاریک',
    ThemeModeOption.system => 'سیستم',
  };

  String get storageKey => name;

  ThemeMode get themeMode => switch (this) {
    ThemeModeOption.light => ThemeMode.light,
    ThemeModeOption.dark => ThemeMode.dark,
    ThemeModeOption.system => ThemeMode.system,
  };

  static ThemeModeOption fromStorageKey(String key) {
    return ThemeModeOption.values.firstWhere(
      (option) => option.storageKey == key,
      orElse: () => ThemeModeOption.system,
    );
  }
}
