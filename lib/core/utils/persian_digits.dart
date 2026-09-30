const List<String> _persianDigits = [
  '۰',
  '۱',
  '۲',
  '۳',
  '۴',
  '۵',
  '۶',
  '۷',
  '۸',
  '۹',
];

/// Normalize digits without discarding decimal separators, signs or invalid
/// characters. Parsers can then reject malformed values rather than changing them.
String toLatinDigits(String input) => String.fromCharCodes(
  input.runes.map((rune) {
    if (rune >= 0x06F0 && rune <= 0x06F9) return rune - 0x06F0 + 0x30;
    if (rune >= 0x0660 && rune <= 0x0669) return rune - 0x0660 + 0x30;
    return rune;
  }),
);

/// Replaces every Latin digit (0-9) in [input] with its Persian equivalent
/// (۰-۹), leaving separators, punctuation, and any other characters
/// untouched. Used at display time only — parsing/validation always works
/// with Latin-digit strings, since that's what the numeric keyboard and
/// `int.tryParse`/`num.tryParse` produce.
String toPersianDigits(String input) {
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    if (rune >= 0x30 && rune <= 0x39) {
      buffer.write(_persianDigits[rune - 0x30]);
    } else {
      buffer.writeCharCode(rune);
    }
  }
  return buffer.toString();
}
