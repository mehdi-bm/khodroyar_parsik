import 'package:flutter/material.dart' show DateTimeRange;
import 'package:shamsi_date/shamsi_date.dart';

/// Calendar boundaries are computed in local civil time, not by subtracting
/// fixed durations (which would mis-handle leap years and month lengths).
abstract final class JalaliPeriod {
  static DateTime monthStart(DateTime date, {int offset = 0}) {
    final j = Jalali.fromDateTime(date);
    final index = j.year * 12 + j.month - 1 + offset;
    return Jalali(index ~/ 12, index % 12 + 1, 1).toDateTime();
  }

  static DateTimeRange month(DateTime date, {int offset = 0}) => DateTimeRange(
    start: monthStart(date, offset: offset),
    end: monthStart(
      date,
      offset: offset + 1,
    ).subtract(const Duration(microseconds: 1)),
  );

  static DateTimeRange year(DateTime date) {
    final year = Jalali.fromDateTime(date).year;
    return DateTimeRange(
      start: Jalali(year, 1, 1).toDateTime(),
      end: Jalali(
        year + 1,
        1,
        1,
      ).toDateTime().subtract(const Duration(microseconds: 1)),
    );
  }
}
