import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/timeline/domain/timeline_entry.dart';

MaintenanceRecord _maintenance(DateTime date) => MaintenanceRecord(
  id: 1,
  vehicleId: 1,
  title: 'تعویض روغن',
  category: 'engineOil',
  date: date,
  mileage: 1000,
  cost: 500000,
  description: null,
  photoPath: null,
  nextServiceMileage: null,
  nextServiceDate: null,
  createdAt: date,
);

FuelRecord _fuel(DateTime date) => FuelRecord(
  id: 2,
  vehicleId: 1,
  date: date,
  mileage: 1200,
  fuelAmountLiters: 40,
  totalCost: 1400000,
  pricePerLiter: null,
  isFullTank: true,
  notes: null,
  createdAt: date,
);

ExpenseRecord _expense(DateTime date) => ExpenseRecord(
  id: 3,
  vehicleId: 1,
  category: 'insurance',
  amount: 450000,
  date: date,
  description: null,
  photoPath: null,
  createdAt: date,
);

Document _document(DateTime createdAt) => Document(
  id: 4,
  vehicleId: 1,
  title: 'بیمه شخص ثالث',
  type: 'insurance',
  startDate: null,
  expirationDate: createdAt.add(const Duration(days: 365)),
  photoPath: null,
  notes: null,
  createdAt: createdAt,
);

void main() {
  group('computeTimeline', () {
    test('merges every record type sorted newest first', () {
      final entries = computeTimeline(
        maintenanceRecords: [_maintenance(DateTime(2026, 1, 1))],
        fuelRecords: [_fuel(DateTime(2026, 3, 1))],
        expenseRecords: [_expense(DateTime(2026, 2, 1))],
        documents: [_document(DateTime(2026, 4, 1))],
      );

      expect(entries, hasLength(4));
      expect(entries[0].kind, TimelineEntryKind.document);
      expect(entries[1].kind, TimelineEntryKind.fuel);
      expect(entries[2].kind, TimelineEntryKind.expense);
      expect(entries[3].kind, TimelineEntryKind.maintenance);
    });

    test('is not capped — unlike computeRecentActivities', () {
      final many = [
        for (var i = 0; i < 20; i++)
          _maintenance(DateTime(2026, 1, 1).add(Duration(days: i))),
      ];
      final entries = computeTimeline(
        maintenanceRecords: many,
        fuelRecords: const [],
        expenseRecords: const [],
        documents: const [],
      );
      expect(entries, hasLength(20));
    });

    test('documents carry no amount', () {
      final entries = computeTimeline(
        maintenanceRecords: const [],
        fuelRecords: const [],
        expenseRecords: const [],
        documents: [_document(DateTime(2026, 1, 1))],
      );
      expect(entries.single.amount, isNull);
    });

    test('a document is keyed by createdAt, not its expiration date', () {
      final created = DateTime(2026, 1, 1);
      final entries = computeTimeline(
        maintenanceRecords: const [],
        fuelRecords: const [],
        expenseRecords: const [],
        documents: [_document(created)],
      );
      expect(entries.single.date, created);
    });

    test('mileage and liters use grouped Persian digits like the rest of the app', () {
      final entries = computeTimeline(
        maintenanceRecords: [_maintenance(DateTime(2026, 1, 1))],
        fuelRecords: [_fuel(DateTime(2026, 2, 1))],
        expenseRecords: const [],
        documents: const [],
      );
      expect(entries[0].subtitle, '۴۰ لیتر  •  ۱,۲۰۰ کیلومتر');
      expect(entries[1].subtitle, '۱,۰۰۰ کیلومتر');
    });

    test('expense title resolves through ExpenseCategory labels', () {
      final entries = computeTimeline(
        maintenanceRecords: const [],
        fuelRecords: const [],
        expenseRecords: [_expense(DateTime(2026, 1, 1))],
        documents: const [],
      );
      expect(entries.single.title, isNotEmpty);
      expect(entries.single.amount, 450000);
    });
  });
}
