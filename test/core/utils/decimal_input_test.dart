import 'package:flutter_test/flutter_test.dart';
import 'package:caryar/core/utils/decimal_input.dart';
import 'package:caryar/features/fuel/domain/fuel_validators.dart';
import 'package:caryar/features/vehicles/domain/vehicle_validators.dart';

void main() {
  test(
    'normalizes Persian and Arabic decimals without changing their value',
    () {
      expect(normalizeDecimalInput('۳۵٫۷۵'), '35.75');
      expect(normalizeDecimalInput('٣٥.٧٥'), '35.75');
      expect(FuelValidators.fuelAmount('۳۵٫۷۵'), isNull);
      expect(FuelValidators.fuelAmount('NaN'), isNotNull);
      expect(FuelValidators.fuelAmount('Infinity'), isNotNull);
      expect(FuelValidators.fuelAmount('-۲٫۵'), isNotNull);
      expect(FuelValidators.fuelAmount('12abc'), isNotNull);
    },
  );
  test(
    'Persian model years are accepted, malformed numeric fields are rejected',
    () {
      expect(VehicleValidators.modelYear('۱۴۰۳'), isNull);
      expect(VehicleValidators.modelYear('١٤٠٣'), isNull);
      expect(VehicleValidators.modelYear('14xx03'), isNotNull);
      expect(VehicleValidators.mileage('12.5'), isNotNull);
    },
  );
}
