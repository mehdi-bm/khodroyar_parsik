import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/fuel/domain/fuel_consumption_calculator.dart';

FuelRecord _record({
  required int id,
  required int mileage,
  required double fuelAmountLiters,
  bool isFullTank = true,
}) {
  return FuelRecord(
    id: id,
    vehicleId: 1,
    date: DateTime(2026, 1, 1).add(Duration(days: id)),
    mileage: mileage,
    fuelAmountLiters: fuelAmountLiters,
    totalCost: (fuelAmountLiters * 35000).round(),
    pricePerLiter: 35000,
    isFullTank: isFullTank,
    notes: null,
    createdAt: DateTime(2026, 1, 1),
  );
}

void main() {
  group('consumptionAt', () {
    test('returns null for a partial fill-up', () {
      final records = [
        _record(id: 1, mileage: 80000, fuelAmountLiters: 40),
        _record(id: 2, mileage: 80300, fuelAmountLiters: 15, isFullTank: false),
      ];
      expect(consumptionAt(records, records[1]), isNull);
    });

    test('returns null when there is no earlier full tank', () {
      final records = [_record(id: 1, mileage: 80000, fuelAmountLiters: 40)];
      expect(consumptionAt(records, records[0]), isNull);
    });

    test('computes liters/100km between two consecutive full tanks', () {
      final records = [
        _record(id: 1, mileage: 80000, fuelAmountLiters: 40),
        _record(id: 2, mileage: 80500, fuelAmountLiters: 37),
      ];
      // 37L over 500km = 7.4 L/100km
      expect(consumptionAt(records, records[1]), closeTo(7.4, 0.0001));
    });

    test('includes partial fill-ups since the last full tank', () {
      final records = [
        _record(id: 1, mileage: 80000, fuelAmountLiters: 40),
        _record(id: 2, mileage: 80200, fuelAmountLiters: 10, isFullTank: false),
        _record(id: 3, mileage: 80500, fuelAmountLiters: 37),
      ];
      // 10L partial + 37L final fill over 500km = 9.4 L/100km.
      expect(consumptionAt(records, records[2]), closeTo(9.4, 0.0001));
    });

    test('returns null for a non-positive distance', () {
      final records = [
        _record(id: 1, mileage: 80000, fuelAmountLiters: 40),
        _record(id: 2, mileage: 80000, fuelAmountLiters: 37),
      ];
      expect(consumptionAt(records, records[1]), isNull);
    });
  });

  group('latestFuelConsumption', () {
    test('returns null with fewer than two full tanks', () {
      expect(latestFuelConsumption([]), isNull);
      expect(
        latestFuelConsumption([
          _record(id: 1, mileage: 80000, fuelAmountLiters: 40),
        ]),
        isNull,
      );
    });

    test(
      'uses the two most recent full tanks, ignoring a trailing partial',
      () {
        final records = [
          _record(id: 1, mileage: 80000, fuelAmountLiters: 40),
          _record(id: 2, mileage: 80500, fuelAmountLiters: 37),
          _record(
            id: 3,
            mileage: 80700,
            fuelAmountLiters: 12,
            isFullTank: false,
          ),
        ];
        expect(latestFuelConsumption(records), closeTo(7.4, 0.0001));
      },
    );
  });

  test(
    'formatFuelConsumption renders one decimal place with Persian digits',
    () {
      expect(formatFuelConsumption(7.4), '۷.۴ لیتر در ۱۰۰ کیلومتر');
      expect(formatFuelConsumption(7.0), '۷.۰ لیتر در ۱۰۰ کیلومتر');
    },
  );
}
