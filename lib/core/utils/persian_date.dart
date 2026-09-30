import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'persian_digits.dart';

/// Formats a Gregorian [DateTime] as a Jalali (Persian calendar) date
/// string with Persian digits (e.g. "۱۴۰۵/۰۵/۲۰") — the calendar and digit
/// style Iranian users expect to read.
String formatJalaliDate(DateTime date) {
  final jalali = Jalali.fromDateTime(date);
  String two(int n) => n.toString().padLeft(2, '0');
  return toPersianDigits(
    '${jalali.year}/${two(jalali.month)}/${two(jalali.day)}',
  );
}

const List<String> _jalaliMonthNames = [
  'فروردین',
  'اردیبهشت',
  'خرداد',
  'تیر',
  'مرداد',
  'شهریور',
  'مهر',
  'آبان',
  'آذر',
  'دی',
  'بهمن',
  'اسفند',
];

/// The Jalali month name for [date], e.g. "مرداد" — used for chart axis
/// labels where a full date would be too wide.
String jalaliMonthLabel(DateTime date) =>
    _jalaliMonthNames[Jalali.fromDateTime(date).month - 1];

/// "مرداد ۱۴۰۵" — a Jalali month+year label, used as a group header (e.g.
/// the full history timeline) where the day isn't meaningful.
String jalaliMonthYearLabel(DateTime date) {
  final jalali = Jalali.fromDateTime(date);
  return toPersianDigits('${_jalaliMonthNames[jalali.month - 1]} ${jalali.year}');
}

/// Shows a real Jalali (Shamsi) calendar picker — replaces Flutter's
/// built-in Gregorian [showDatePicker], which only ever showed Gregorian
/// month/day numbers with Persian digit skinning, not the calendar Iranian
/// users actually think in. Every date field in the app is stored and
/// worked with as a Gregorian [DateTime]; this converts at the boundary so
/// callers never touch [Jalali] themselves.
Future<DateTime?> pickJalaliDate({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  final picked = await showPersianDatePicker(
    context: context,
    initialDate: Jalali.fromDateTime(initialDate),
    firstDate: Jalali.fromDateTime(firstDate),
    lastDate: Jalali.fromDateTime(lastDate),
  );
  return picked?.toDateTime();
}
