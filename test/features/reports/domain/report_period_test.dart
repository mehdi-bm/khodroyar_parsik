import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/reports/domain/report_period.dart';

void main() {
  final now = DateTime(2026, 5, 15, 12);

  test('thisMonth spans the whole current month', () {
    final range = ReportPeriod.thisMonth.rangeFor(now);
    expect(range.start, DateTime(2026, 4, 21));
    expect(range.end, DateTime(2026, 5, 21, 23, 59, 59, 999, 999));
  });

  test('lastMonth spans the previous month', () {
    final range = ReportPeriod.lastMonth.rangeFor(now);
    expect(range.start, DateTime(2026, 3, 21));
    expect(range.end, DateTime(2026, 4, 20, 23, 59, 59, 999, 999));
  });

  test('lastMonth handles Nowruz and a leap Esfand', () {
    final range = ReportPeriod.lastMonth.rangeFor(DateTime(2025, 3, 21));
    expect(range.start, DateTime(2025, 2, 19));
    expect(range.end, DateTime(2025, 3, 20, 23, 59, 59, 999, 999));
  });

  test('thisYear spans the whole current year', () {
    final range = ReportPeriod.thisYear.rangeFor(now);
    expect(range.start, DateTime(2026, 3, 21));
    expect(range.end, DateTime(2027, 3, 20, 23, 59, 59, 999, 999));
  });
}
