import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/database/app_database.dart';
import '../../../core/utils/number_format.dart';
import '../../../core/utils/persian_date.dart';
import '../../expenses/domain/expense_category.dart';
import '../domain/report_calculator.dart';
import '../domain/report_period.dart';

/// Builds the "خروجی PDF" report — a printable summary of one vehicle's
/// costs and history for a period, handy when selling the car or just
/// keeping an outside-the-app record. Every string in the document goes
/// through the bundled Vazirmatn font with RTL text direction so Persian
/// renders correctly (the `pdf` package's default Helvetica has no Persian
/// glyphs at all).
class PdfReportBuilder {
  /// The `pdf` package's Arabic shaper draws ZWNJ (نیم‌فاصله) as a stray
  /// glyph and scrambles word order around it. A thin space keeps the
  /// correct final/initial letter forms and renders cleanly. Applied to every
  /// string — user-entered titles contain ZWNJ as often as our own labels.
  static String _t(String text) => text.replaceAll('‌', ' ');

  Future<pw.Document> build({
    required Vehicle vehicle,
    required ReportPeriod period,
    required ReportSummary summary,
    required List<MaintenanceRecord> maintenanceRecords,
    required List<FuelRecord> fuelRecords,
    required List<ExpenseRecord> expenseRecords,
  }) async {
    final regularFont = pw.Font.ttf(
      await rootBundle.load(
        'assets/fonts/Vazirmatn/Vazirmatn-Regular.ttf',
      ),
    );
    final boldFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/Vazirmatn/Vazirmatn-Bold.ttf'),
    );

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),
    );

    final now = DateTime.now();
    final range = period.rangeFor(now);
    final maintenanceInRange = maintenanceRecords
        .where((r) => !r.date.isBefore(range.start) && !r.date.isAfter(range.end))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    final fuelInRange = fuelRecords
        .where((r) => !r.date.isBefore(range.start) && !r.date.isAfter(range.end))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    final expenseInRange = expenseRecords
        .where((r) => !r.date.isBefore(range.start) && !r.date.isAfter(range.end))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    doc.addPage(
      pw.MultiPage(
        textDirection: pw.TextDirection.rtl,
        pageFormat: PdfPageFormat.a4,
        header: (context) => _buildHeader(vehicle, period),
        build: (context) => [
          _buildSummarySection(summary),
          pw.SizedBox(height: 16),
          if (maintenanceInRange.isNotEmpty) ...[
            _sectionTitle('سرویس‌ها و تعمیرات'),
            _maintenanceTable(maintenanceInRange),
            pw.SizedBox(height: 16),
          ],
          if (fuelInRange.isNotEmpty) ...[
            _sectionTitle('سوخت‌گیری‌ها'),
            _fuelTable(fuelInRange),
            pw.SizedBox(height: 16),
          ],
          if (expenseInRange.isNotEmpty) ...[
            _sectionTitle('سایر هزینه‌ها'),
            _expenseTable(expenseInRange),
          ],
        ],
      ),
    );

    return doc;
  }

  pw.Widget _buildHeader(Vehicle vehicle, ReportPeriod period) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          _t('گزارش خودرویار پارسیک'),
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 4),
        // Separate labeled lines rather than "·"-joined: a middle dot next to
        // Persian digits (e.g. a plate number) is easily misread as "۰".
        pw.Text(_t('خودرو: ${vehicle.name}')),
        if (vehicle.licensePlate != null)
          pw.Text(_t('پلاک: ${vehicle.licensePlate}')),
        pw.Text(_t('بازه گزارش: ${period.label}')),
        pw.Text(
          _t('تاریخ تهیه گزارش: ${formatJalaliDate(DateTime.now())}'),
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
        ),
        pw.Divider(),
      ],
    );
  }

  pw.Widget _sectionTitle(String title) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 8),
    child: pw.Text(
      _t(title),
      style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
    ),
  );

  pw.Widget _buildSummarySection(ReportSummary summary) {
    pw.Widget cell(String label, String value) => pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            _t(label),
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
          pw.Text(
            _t(value),
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );

    return pw.Row(
      children: [
        cell('هزینه سرویس', '${formatNumber(summary.maintenanceCost)} تومان'),
        cell('هزینه سوخت', '${formatNumber(summary.fuelCost)} تومان'),
        cell('سایر هزینه‌ها', '${formatNumber(summary.otherExpenseCost)} تومان'),
        cell('جمع کل', '${formatNumber(summary.totalCost)} تومان'),
      ],
    );
  }

  pw.Widget _maintenanceTable(List<MaintenanceRecord> records) {
    return _table(
      headers: ['تاریخ', 'عنوان', 'کیلومتر', 'هزینه (تومان)'],
      rows: [
        for (final r in records)
          [
            formatJalaliDate(r.date),
            r.title,
            formatNumber(r.mileage),
            formatNumber(r.cost),
          ],
      ],
    );
  }

  pw.Widget _fuelTable(List<FuelRecord> records) {
    return _table(
      headers: ['تاریخ', 'کیلومتر', 'مقدار (لیتر)', 'هزینه (تومان)'],
      rows: [
        for (final r in records)
          [
            formatJalaliDate(r.date),
            formatNumber(r.mileage),
            formatNumber(r.fuelAmountLiters),
            formatNumber(r.totalCost),
          ],
      ],
    );
  }

  pw.Widget _expenseTable(List<ExpenseRecord> records) {
    return _table(
      headers: ['تاریخ', 'دسته‌بندی', 'هزینه (تومان)'],
      rows: [
        for (final r in records)
          [
            formatJalaliDate(r.date),
            ExpenseCategory.fromStorageKey(r.category).label,
            formatNumber(r.amount),
          ],
      ],
    );
  }

  pw.Widget _table({
    required List<String> headers,
    required List<List<String>> rows,
  }) {
    return pw.TableHelper.fromTextArray(
      headers: headers.map(_t).toList(),
      data: [
        for (final row in rows) row.map(_t).toList(),
      ],
      cellAlignment: pw.Alignment.centerRight,
      headerAlignment: pw.Alignment.centerRight,
    );
  }
}
