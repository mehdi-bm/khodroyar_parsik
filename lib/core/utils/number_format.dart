import 'package:intl/intl.dart';

import 'persian_digits.dart';

final NumberFormat _decimalFormat = NumberFormat.decimalPattern('en');

/// Formats a number with thousands separators and Persian digits — matching
/// the app's number-formatting convention (e.g. "۸۷,۴۵۰ کیلومتر"). Uses the
/// 'en' locale pattern for grouping/decimal punctuation (comma/dot, not the
/// Arabic separators ICU's 'fa' locale would pick), then swaps digits to
/// Persian as a final display-only step — parsing always works with plain
/// Latin-digit strings.
String formatNumber(num value) => toPersianDigits(_decimalFormat.format(value));
