import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/utils/number_format.dart';

void main() {
  group('formatNumber', () {
    test('adds thousands separators with Persian digits', () {
      expect(formatNumber(1500000), '۱,۵۰۰,۰۰۰');
    });

    test('renders zero without a separator', () {
      expect(formatNumber(0), '۰');
    });

    test('leaves small numbers unseparated', () {
      expect(formatNumber(450), '۴۵۰');
    });

    test('handles a value right at the thousands boundary', () {
      expect(formatNumber(1000), '۱,۰۰۰');
      expect(formatNumber(999), '۹۹۹');
    });
  });
}
