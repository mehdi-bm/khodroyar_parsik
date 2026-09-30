import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/expenses/domain/expense_validators.dart';

void main() {
  group('ExpenseValidators.amount', () {
    test('rejects empty, non-numeric, zero, and negative', () {
      expect(ExpenseValidators.amount(''), isNotNull);
      expect(ExpenseValidators.amount('abc'), isNotNull);
      expect(ExpenseValidators.amount('0'), isNotNull);
      expect(ExpenseValidators.amount('-500'), isNotNull);
    });

    test('accepts a positive amount', () {
      expect(ExpenseValidators.amount('450000'), isNull);
    });
  });
}
