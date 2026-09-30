import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/advertising/domain/support_validators.dart';

void main() {
  group('SupportValidators.errorDescription', () {
    test('rejects empty and under-5-character input', () {
      expect(SupportValidators.errorDescription(''), isNotNull);
      expect(SupportValidators.errorDescription('کم'), isNotNull);
    });

    test('accepts a description of exactly 5 characters', () {
      expect(SupportValidators.errorDescription('12345'), isNull);
    });

    test('rejects a description over 4000 characters', () {
      expect(SupportValidators.errorDescription('a' * 4001), isNotNull);
    });
  });

  group('SupportValidators.fullName', () {
    test('rejects empty, too-short, and too-long names', () {
      expect(SupportValidators.fullName(''), isNotNull);
      expect(SupportValidators.fullName('عل'), isNotNull);
      expect(SupportValidators.fullName('a' * 161), isNotNull);
    });

    test('accepts a normal name', () {
      expect(SupportValidators.fullName('علی رضایی'), isNull);
    });
  });

  group('SupportValidators.phoneNumber', () {
    test('accepts a Latin-digit mobile number', () {
      expect(SupportValidators.phoneNumber('09123456789'), isNull);
    });

    test('accepts a Persian-digit mobile number', () {
      expect(SupportValidators.phoneNumber('۰۹۱۲۳۴۵۶۷۸۹'), isNull);
    });

    test('accepts a number with spaces and a leading +', () {
      expect(SupportValidators.phoneNumber('+98 912 345 6789'), isNull);
    });

    test('rejects too few digits', () {
      expect(SupportValidators.phoneNumber('12345'), isNotNull);
    });

    test('rejects too many digits', () {
      expect(SupportValidators.phoneNumber('1' * 21), isNotNull);
    });
  });

  group('SupportValidators.province / city', () {
    test('rejects empty and single-character input', () {
      expect(SupportValidators.province(''), isNotNull);
      expect(SupportValidators.province('ت'), isNotNull);
      expect(SupportValidators.city(''), isNotNull);
      expect(SupportValidators.city('ت'), isNotNull);
    });

    test('accepts a normal value', () {
      expect(SupportValidators.province('تهران'), isNull);
      expect(SupportValidators.city('تهران'), isNull);
    });
  });

  group('SupportValidators.details', () {
    test('is optional', () {
      expect(SupportValidators.details(''), isNull);
      expect(SupportValidators.details(null), isNull);
    });

    test('rejects over 4000 characters', () {
      expect(SupportValidators.details('a' * 4001), isNotNull);
    });
  });
}
