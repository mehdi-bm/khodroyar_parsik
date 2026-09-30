import 'package:flutter/material.dart' show DateTimeRange;
import '../../../core/utils/jalali_period.dart';

/// The three quick filters from the spec (section 14/18). A custom date
/// range was deliberately left out — the spec only asks for it "if easy to
/// implement", and a proper range picker adds real validation/UX surface
/// for a report screen that's meant to stay simple.
enum ReportPeriod {
  thisMonth,
  lastMonth,
  thisYear;

  String get label => switch (this) {
    ReportPeriod.thisMonth => 'این ماه',
    ReportPeriod.lastMonth => 'ماه گذشته',
    ReportPeriod.thisYear => 'امسال',
  };

  /// The [start, end] range this period covers, relative to [now].
  DateTimeRange rangeFor(DateTime now) {
    switch (this) {
      case ReportPeriod.thisMonth:
        return JalaliPeriod.month(now);
      case ReportPeriod.lastMonth:
        return JalaliPeriod.month(now, offset: -1);
      case ReportPeriod.thisYear:
        return JalaliPeriod.year(now);
    }
  }
}
