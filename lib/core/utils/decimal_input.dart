import 'package:flutter/services.dart';

import 'persian_digits.dart';

/// Accept Persian/Arabic digits and the Arabic decimal separator used by
/// Persian keyboards, while retaining signs for validation.
String normalizeDecimalInput(String value) =>
    toLatinDigits(value.trim()).replaceAll('٫', '.');

/// Shows typed digits as Persian (like the grouped number fields) for
/// decimal inputs, where grouping doesn't apply. Digit mapping is 1:1 per
/// character, so the selection stays valid; parse with
/// [normalizeDecimalInput].
class PersianDigitsInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) => newValue.copyWith(text: toPersianDigits(newValue.text));
}
