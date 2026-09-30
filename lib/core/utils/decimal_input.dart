import 'persian_digits.dart';

/// Accept Persian/Arabic digits and the Arabic decimal separator used by
/// Persian keyboards, while retaining signs for validation.
String normalizeDecimalInput(String value) =>
    toLatinDigits(value.trim()).replaceAll('٫', '.');
