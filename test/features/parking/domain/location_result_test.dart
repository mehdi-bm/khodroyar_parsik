import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/parking/domain/location_result.dart';

void main() {
  test('every LocationFailureReason has a non-empty Persian message', () {
    for (final reason in LocationFailureReason.values) {
      expect(LocationFailure(reason).message, isNotEmpty);
    }
  });
}
