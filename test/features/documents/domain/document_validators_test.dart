import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/documents/domain/document_validators.dart';

void main() {
  group('DocumentValidators.title', () {
    test('rejects empty', () {
      expect(DocumentValidators.title(''), isNotNull);
      expect(DocumentValidators.title(null), isNotNull);
    });

    test('accepts a normal title', () {
      expect(DocumentValidators.title('بیمه شخص ثالث'), isNull);
    });
  });

  group('DocumentValidators.expirationDate', () {
    test('accepts when there is no start date', () {
      expect(
        DocumentValidators.expirationDate(
          startDate: null,
          expirationDate: DateTime(2026, 1, 1),
        ),
        isNull,
      );
    });

    test('rejects an expiration date not after the start date', () {
      expect(
        DocumentValidators.expirationDate(
          startDate: DateTime(2026, 1, 1),
          expirationDate: DateTime(2026, 1, 1),
        ),
        isNotNull,
      );
      expect(
        DocumentValidators.expirationDate(
          startDate: DateTime(2026, 6, 1),
          expirationDate: DateTime(2026, 1, 1),
        ),
        isNotNull,
      );
    });

    test('accepts an expiration date after the start date', () {
      expect(
        DocumentValidators.expirationDate(
          startDate: DateTime(2026, 1, 1),
          expirationDate: DateTime(2027, 1, 1),
        ),
        isNull,
      );
    });
  });
}
