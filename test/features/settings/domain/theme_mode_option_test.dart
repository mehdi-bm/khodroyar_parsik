import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/settings/domain/theme_mode_option.dart';

void main() {
  group('ThemeModeOption', () {
    test('storageKey round-trips through fromStorageKey', () {
      for (final option in ThemeModeOption.values) {
        expect(ThemeModeOption.fromStorageKey(option.storageKey), option);
      }
    });

    test('fromStorageKey falls back to system for unknown keys', () {
      expect(ThemeModeOption.fromStorageKey('unknown'), ThemeModeOption.system);
    });

    test('maps to the matching Flutter ThemeMode', () {
      expect(ThemeModeOption.light.themeMode, ThemeMode.light);
      expect(ThemeModeOption.dark.themeMode, ThemeMode.dark);
      expect(ThemeModeOption.system.themeMode, ThemeMode.system);
    });
  });
}
