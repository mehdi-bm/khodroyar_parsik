import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/utils/persian_date.dart';

void main() {
  test('formats Nowruz (Persian New Year) as 01/01', () {
    // Confirmed via shamsi_date: 2025-03-20 is Jalali 1403/12/30 (the last
    // day of 1403), so Nowruz 1404 fell on 2025-03-21.
    expect(formatJalaliDate(DateTime(2025, 3, 21)), '۱۴۰۴/۰۱/۰۱');
  });

  test('pads single-digit month/day with a leading zero', () {
    // Farvandin 1404 has 31 days (2025-03-21 .. 2025-04-20), so the next
    // day rolls into month 2, day 1 — both single digits, both padded.
    expect(formatJalaliDate(DateTime(2025, 4, 21)), '۱۴۰۴/۰۲/۰۱');
  });

  test('jalaliMonthLabel names the Jalali month', () {
    // 2025-03-21 is Farvardin 1404/01/01 (see above).
    expect(jalaliMonthLabel(DateTime(2025, 3, 21)), 'فروردین');
    // 2025-04-21 is Ordibehesht 1404/02/01.
    expect(jalaliMonthLabel(DateTime(2025, 4, 21)), 'اردیبهشت');
  });
}
