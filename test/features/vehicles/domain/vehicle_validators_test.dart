import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/vehicles/domain/vehicle_validators.dart';

void main() {
  group('VehicleValidators.name', () {
    test('rejects empty', () {
      expect(VehicleValidators.name(''), isNotNull);
      expect(VehicleValidators.name('   '), isNotNull);
      expect(VehicleValidators.name(null), isNotNull);
    });

    test('accepts a normal name', () {
      expect(VehicleValidators.name('پژو ۲۰۶'), isNull);
    });

    test('rejects an unreasonably long name', () {
      expect(VehicleValidators.name('ا' * 101), isNotNull);
    });
  });

  group('VehicleValidators.mileage', () {
    test('rejects empty, non-numeric, and negative', () {
      expect(VehicleValidators.mileage(''), isNotNull);
      expect(VehicleValidators.mileage('abc'), isNotNull);
      expect(VehicleValidators.mileage('-5'), isNotNull);
    });

    test('accepts zero and positive integers', () {
      expect(VehicleValidators.mileage('0'), isNull);
      expect(VehicleValidators.mileage('87450'), isNull);
    });
  });

  group('VehicleValidators.modelYear', () {
    test('is optional', () {
      expect(VehicleValidators.modelYear(''), isNull);
      expect(VehicleValidators.modelYear(null), isNull);
    });

    test('rejects out-of-range or non-numeric years', () {
      expect(VehicleValidators.modelYear('abc'), isNotNull);
      expect(VehicleValidators.modelYear('900'), isNotNull);
      expect(VehicleValidators.modelYear('2500'), isNotNull);
    });

    test('accepts a plausible Persian calendar year', () {
      expect(VehicleValidators.modelYear('1400'), isNull);
    });
  });
}
