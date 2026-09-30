import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/fuel/domain/fuel_validators.dart';

void main() {
  group('FuelValidators.mileage', () {
    test('rejects empty, non-numeric, and negative', () {
      expect(FuelValidators.mileage(''), isNotNull);
      expect(FuelValidators.mileage('abc'), isNotNull);
      expect(FuelValidators.mileage('-1'), isNotNull);
    });

    test('accepts a valid mileage with no prior record', () {
      expect(FuelValidators.mileage('1000'), isNull);
    });

    test('rejects a mileage not after the previous fill-up', () {
      expect(FuelValidators.mileage('1000', previousMileage: 1000), isNotNull);
      expect(FuelValidators.mileage('900', previousMileage: 1000), isNotNull);
    });

    test('accepts a mileage after the previous fill-up', () {
      expect(FuelValidators.mileage('1100', previousMileage: 1000), isNull);
    });
  });

  group('FuelValidators.fuelAmount', () {
    test('rejects empty, non-numeric, zero, and negative', () {
      expect(FuelValidators.fuelAmount(''), isNotNull);
      expect(FuelValidators.fuelAmount('abc'), isNotNull);
      expect(FuelValidators.fuelAmount('0'), isNotNull);
      expect(FuelValidators.fuelAmount('-5'), isNotNull);
    });

    test('accepts a positive decimal amount', () {
      expect(FuelValidators.fuelAmount('35.5'), isNull);
    });
  });

  group('FuelValidators.totalCost', () {
    test('rejects empty, non-numeric, zero, and negative', () {
      expect(FuelValidators.totalCost(''), isNotNull);
      expect(FuelValidators.totalCost('abc'), isNotNull);
      expect(FuelValidators.totalCost('0'), isNotNull);
      expect(FuelValidators.totalCost('-1'), isNotNull);
    });

    test('accepts a positive amount', () {
      expect(FuelValidators.totalCost('1225000'), isNull);
    });
  });
}
