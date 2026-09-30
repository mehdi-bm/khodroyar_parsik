import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/maintenance/domain/maintenance_validators.dart';

void main() {
  group('MaintenanceValidators.title', () {
    test('rejects empty', () {
      expect(MaintenanceValidators.title(''), isNotNull);
      expect(MaintenanceValidators.title(null), isNotNull);
    });

    test('accepts a normal title', () {
      expect(MaintenanceValidators.title('تعویض روغن موتور'), isNull);
    });
  });

  group('MaintenanceValidators.mileage', () {
    test('rejects empty, non-numeric, and negative', () {
      expect(MaintenanceValidators.mileage(''), isNotNull);
      expect(MaintenanceValidators.mileage('abc'), isNotNull);
      expect(MaintenanceValidators.mileage('-1'), isNotNull);
    });

    test('accepts a valid mileage', () {
      expect(MaintenanceValidators.mileage('87450'), isNull);
    });
  });

  group('MaintenanceValidators.cost', () {
    test('is optional', () {
      expect(MaintenanceValidators.cost(''), isNull);
      expect(MaintenanceValidators.cost(null), isNull);
    });

    test('rejects negative or non-numeric', () {
      expect(MaintenanceValidators.cost('-1'), isNotNull);
      expect(MaintenanceValidators.cost('abc'), isNotNull);
    });
  });

  group('MaintenanceValidators.nextServiceMileage', () {
    test('is optional', () {
      expect(
        MaintenanceValidators.nextServiceMileage('', serviceMileage: 1000),
        isNull,
      );
    });

    test('rejects a value not after the service mileage', () {
      expect(
        MaintenanceValidators.nextServiceMileage('1000', serviceMileage: 1000),
        isNotNull,
      );
      expect(
        MaintenanceValidators.nextServiceMileage('900', serviceMileage: 1000),
        isNotNull,
      );
    });

    test('accepts a value after the service mileage', () {
      expect(
        MaintenanceValidators.nextServiceMileage('6000', serviceMileage: 1000),
        isNull,
      );
    });
  });
}
