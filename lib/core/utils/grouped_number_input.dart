import 'package:flutter/services.dart';

import 'persian_digits.dart';

/// Converts every digit in [input] to plain Latin 0-9, accepting Latin,
/// Persian (۰-۹), or Arabic-Indic (٠-٩) digits — covers whatever the
/// device's own keyboard happens to type — and drops everything else
/// (thousands-separator commas, spaces, ...).
String _toLatinDigitsOnly(String input) {
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    if (rune >= 0x30 && rune <= 0x39) {
      buffer.writeCharCode(rune);
    } else if (rune >= 0x06F0 && rune <= 0x06F9) {
      buffer.writeCharCode(rune - 0x06F0 + 0x30);
    } else if (rune >= 0x0660 && rune <= 0x0669) {
      buffer.writeCharCode(rune - 0x0660 + 0x30);
    }
  }
  return buffer.toString();
}

String _groupThousands(String digits) {
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}

/// Formats a plain Latin-digit whole-number string (e.g. from
/// `vehicle.currentMileage.toString()`) into the same grouped, Persian-digit
/// form the live input formatter below produces — used to pre-fill a form
/// field's initial text so an edited record looks the same as freshly
/// typed input, since [TextEditingController.text] assignment bypasses
/// [TextInputFormatter]s.
String formatGroupedDigits(String rawDigits) =>
    toPersianDigits(_groupThousands(_toLatinDigitsOnly(rawDigits)));

/// The inverse of [formatGroupedDigits] — strips grouping commas and
/// converts back to plain Latin digits, suitable for `int.parse`/
/// `num.tryParse`. Call this on a [GroupedNumberInputFormatter] field's
/// text before parsing it anywhere (validators, submit handlers).
///
/// Preserves a leading minus sign: [GroupedNumberInputFormatter] itself
/// never lets one through while typing (these fields are all
/// non-negative quantities), but validators are also called directly
/// with arbitrary strings in tests, and must still correctly recognize
/// and reject a negative value rather than have the sign silently
/// dropped.
String ungroupDigits(String formatted) {
  final trimmed = formatted.trim();
  return toLatinDigits(trimmed).replaceAll(RegExp(r'[,٬\s]'), '');
}

/// Live-formats a whole-number text field with thousands-separator
/// grouping and Persian digits as the user types (e.g. typing "1500000"
/// displays as "۱,۵۰۰,۰۰۰"). Only for whole-number fields (mileage, cost,
/// counts) — not decimals, which grouping doesn't apply to.
///
/// Always places the cursor at the end after reformatting; a deliberate
/// simplification, since these fields are read/typed left-to-right and
/// mid-value edits are rare enough not to justify tracking cursor offset
/// through a changing number of separator characters.
class GroupedNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = _toLatinDigitsOnly(newValue.text);
    if (digitsOnly.isEmpty) {
      return const TextEditingValue();
    }
    final formatted = formatGroupedDigits(digitsOnly);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
