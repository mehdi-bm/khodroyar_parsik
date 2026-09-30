import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'persian_digits.dart';

/// [PersianMaterialLocalizations] with Persian digits — the package formats
/// every number (calendar days, years, the picker header) with Latin digits,
/// unlike the rest of the app. [formatCompactDate] is deliberately left as-is:
/// the picker's type-in mode parses that string back and expects Latin digits.
class AppMaterialLocalizations extends PersianMaterialLocalizations {
  const AppMaterialLocalizations();

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _AppMaterialLocalizationsDelegate();

  @override
  String formatDecimal(int number) => toPersianDigits(super.formatDecimal(number));

  @override
  String formatYear(DateTime date) => toPersianDigits(super.formatYear(date));

  @override
  String formatMediumDate(DateTime date) =>
      toPersianDigits(super.formatMediumDate(date));

  @override
  String formatShortMonthDay(DateTime date) =>
      toPersianDigits(super.formatShortMonthDay(date));

  @override
  String formatShortDate(DateTime date) =>
      toPersianDigits(super.formatShortDate(date));

  @override
  String formatMonthYear(DateTime date) =>
      toPersianDigits(super.formatMonthYear(date));

  @override
  String formatFullDate(DateTime date) =>
      toPersianDigits(super.formatFullDate(date));
}

class _AppMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _AppMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      PersianMaterialLocalizations.delegate.isSupported(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      SynchronousFuture<MaterialLocalizations>(const AppMaterialLocalizations());

  @override
  bool shouldReload(_AppMaterialLocalizationsDelegate old) => false;
}
