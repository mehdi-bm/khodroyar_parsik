import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/maintenance/domain/maintenance_category.dart';

void main() {
  group('MaintenanceCategory', () {
    test('every value has a non-empty Persian label', () {
      for (final category in MaintenanceCategory.values) {
        expect(category.label, isNotEmpty);
      }
    });

    test('storage key round-trips through fromStorageKey', () {
      for (final category in MaintenanceCategory.values) {
        expect(MaintenanceCategory.fromStorageKey(category.name), category);
      }
    });

    test('fromStorageKey falls back to other for unknown keys', () {
      expect(
        MaintenanceCategory.fromStorageKey('unknown'),
        MaintenanceCategory.other,
      );
    });
  });
}
