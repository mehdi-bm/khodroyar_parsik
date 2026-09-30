import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/documents/domain/document_type.dart';

void main() {
  group('DocumentType', () {
    test('every value has a non-empty Persian label', () {
      for (final type in DocumentType.values) {
        expect(type.label, isNotEmpty);
      }
    });

    test('storage key round-trips through fromStorageKey', () {
      for (final type in DocumentType.values) {
        expect(DocumentType.fromStorageKey(type.name), type);
      }
    });

    test('fromStorageKey falls back to other for unknown keys', () {
      expect(DocumentType.fromStorageKey('unknown'), DocumentType.other);
    });
  });
}
