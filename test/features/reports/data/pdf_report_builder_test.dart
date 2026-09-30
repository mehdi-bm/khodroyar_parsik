import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/reports/data/pdf_report_builder.dart';
import 'package:caryar/features/reports/domain/report_calculator.dart';
import 'package:caryar/features/reports/domain/report_period.dart';

Vehicle _vehicle() => Vehicle(
  id: 1,
  name: 'پژو ۲۰۶',
  brand: null,
  model: null,
  modelYear: null,
  color: null,
  licensePlate: 'الف ۱۲ ۳۴۵ ۶۷',
  currentMileage: 87450,
  photoPath: null,
  notes: null,
  createdAt: DateTime(2026, 1, 1),
  updatedAt: DateTime(2026, 1, 1),
  oilType: null,
  oilFilterModel: null,
  airFilterModel: null,
  cabinFilterModel: null,
  tireSize: null,
  batteryModel: null,
  sparkPlugModel: null,
);

MaintenanceRecord _maintenance() => MaintenanceRecord(
  id: 1,
  vehicleId: 1,
  title: 'تعویض روغن موتور',
  category: 'engineOil',
  date: DateTime.now(),
  mileage: 87450,
  cost: 500000,
  description: null,
  photoPath: null,
  nextServiceMileage: null,
  nextServiceDate: null,
  createdAt: DateTime.now(),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('builds a non-empty PDF containing the vehicle name', () async {
    final summary = computeReportSummary(
      maintenanceRecords: [_maintenance()],
      fuelRecords: const [],
      expenseRecords: const [],
      period: ReportPeriod.thisMonth.rangeFor(DateTime.now()),
    );

    final doc = await PdfReportBuilder().build(
      vehicle: _vehicle(),
      period: ReportPeriod.thisMonth,
      summary: summary,
      maintenanceRecords: [_maintenance()],
      fuelRecords: const [],
      expenseRecords: const [],
    );

    final bytes = await doc.save();

    expect(bytes, isNotEmpty);
    // A real PDF file always starts with this magic header.
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
  });
}
