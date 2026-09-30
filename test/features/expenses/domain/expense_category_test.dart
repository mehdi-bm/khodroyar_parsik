import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/expenses/domain/expense_category.dart';

void main() {
  group('ExpenseCategory', () {
    test('every value has a non-empty Persian label', () {
      for (final category in ExpenseCategory.values) {
        expect(category.label, isNotEmpty);
      }
    });

    test(
      'deliberately excludes maintenance and fuel to avoid double-counting',
      () {
        final names = ExpenseCategory.values.map((c) => c.name);
        expect(names, isNot(contains('maintenance')));
        expect(names, isNot(contains('fuel')));
      },
    );

    test('storage key round-trips through fromStorageKey', () {
      for (final category in ExpenseCategory.values) {
        expect(ExpenseCategory.fromStorageKey(category.name), category);
      }
    });

    test('fromStorageKey falls back to other for unknown keys', () {
      expect(ExpenseCategory.fromStorageKey('unknown'), ExpenseCategory.other);
    });
  });
}
