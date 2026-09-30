import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/utils/grouped_number_input.dart';

void main() {
  group('formatGroupedDigits', () {
    test('groups digits in threes with Persian digits', () {
      expect(formatGroupedDigits('1500000'), '۱,۵۰۰,۰۰۰');
    });

    test('does not group short numbers', () {
      expect(formatGroupedDigits('45'), '۴۵');
    });

    test('handles empty input', () {
      expect(formatGroupedDigits(''), '');
    });

    test('groups a number right at the thousands boundary', () {
      expect(formatGroupedDigits('1000'), '۱,۰۰۰');
      expect(formatGroupedDigits('999'), '۹۹۹');
    });
  });

  group('ungroupDigits', () {
    test('strips separators and converts Persian digits back to Latin', () {
      expect(ungroupDigits('۱,۵۰۰,۰۰۰'), '1500000');
    });

    test('round-trips through formatGroupedDigits', () {
      expect(ungroupDigits(formatGroupedDigits('87450')), '87450');
    });

    test('also accepts already-Latin grouped input', () {
      expect(ungroupDigits('1,500,000'), '1500000');
    });

    test('preserves a leading minus sign so negative values still parse', () {
      expect(ungroupDigits('-5'), '-5');
      expect(int.tryParse(ungroupDigits('-5')), -5);
    });
  });

  group('GroupedNumberInputFormatter', () {
    late GroupedNumberInputFormatter formatter;

    setUp(() {
      formatter = GroupedNumberInputFormatter();
    });

    test('formats typed Latin digits live', () {
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '1500000'),
      );
      expect(result.text, '۱,۵۰۰,۰۰۰');
      expect(result.selection.baseOffset, result.text.length);
    });

    test('accepts digits typed via a Persian keyboard', () {
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '۴۵۰۰۰'),
      );
      expect(result.text, '۴۵,۰۰۰');
    });

    test('clearing the field produces empty text, not a stray separator', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: '۱,۵۰۰'),
        const TextEditingValue(text: ''),
      );
      expect(result.text, '');
    });
  });
}
