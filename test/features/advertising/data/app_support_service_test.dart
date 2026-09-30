import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/advertising/data/ads_config.dart';
import 'package:caryar/features/advertising/data/ads_exceptions.dart';
import 'package:caryar/features/advertising/data/app_support_service.dart';

import '../../../support/fake_ads_http_transport.dart';

void main() {
  const configured = AdsConfig(
    baseUrl: 'https://ads.parsikonline.ir/',
    apiKey: 'test-api-key',
    externalAppApiKey: 'test-external-key',
    appName: 'parsik_khodroyar',
    platform: 'Android',
    sectionCode: '',
  );
  const notConfigured = AdsConfig(
    baseUrl: 'https://ads.parsikonline.ir/',
    apiKey: '',
    externalAppApiKey: '',
    appName: 'parsik_khodroyar',
    platform: 'Android',
    sectionCode: '',
  );

  group('AppSupportService.submitErrorReport', () {
    test(
      'trims and sends description, includes both API-key headers',
      () async {
        final transport = FakeAdsHttpTransport()
          ..defaultResponse = jsonResponse(201, {
            'id': 'r1',
            'type': 'ErrorReport',
            'status': 'New',
          });
        final service = AppSupportService(configured, transport: transport);

        final receipt = await service.submitErrorReport(
          description: '  مشکل در ثبت سوخت  ',
        );

        final request = transport.requests.single;
        expect(request.headers['X-API-KEY'], 'test-api-key');
        expect(request.headers['X-EXTERNAL-APP-API-KEY'], 'test-external-key');
        expect(request.body, contains('"description":"مشکل در ثبت سوخت"'));
        expect(receipt.id, 'r1');
        expect(receipt.type, 'ErrorReport');
      },
    );

    test(
      'rejects a description under 5 characters without a network call',
      () async {
        final transport = FakeAdsHttpTransport();
        final service = AppSupportService(configured, transport: transport);

        await expectLater(
          service.submitErrorReport(description: 'کم'),
          throwsA(
            isA<AdsApiException>().having(
              (e) => e.kind,
              'kind',
              AdsErrorKind.validation,
            ),
          ),
        );
        expect(transport.requests, isEmpty);
      },
    );

    test('rejects a description over 4000 characters', () async {
      final transport = FakeAdsHttpTransport();
      final service = AppSupportService(configured, transport: transport);

      await expectLater(
        service.submitErrorReport(description: 'a' * 4001),
        throwsA(isA<AdsApiException>()),
      );
      expect(transport.requests, isEmpty);
    });

    test('a non-201 status maps to the right error kind', () async {
      final transport = FakeAdsHttpTransport()
        ..defaultResponse = emptyResponse(500);
      final service = AppSupportService(configured, transport: transport);

      await expectLater(
        service.submitErrorReport(description: 'یک مشکل واقعی'),
        throwsA(
          isA<AdsApiException>().having(
            (e) => e.kind,
            'kind',
            AdsErrorKind.server,
          ),
        ),
      );
    });

    test(
      'an empty successful body is not treated as a valid receipt',
      () async {
        final transport = FakeAdsHttpTransport()
          ..defaultResponse = emptyResponse(201);
        final service = AppSupportService(configured, transport: transport);

        await expectLater(
          service.submitErrorReport(description: 'یک مشکل واقعی'),
          throwsA(
            isA<AdsApiException>().having(
              (e) => e.kind,
              'kind',
              AdsErrorKind.invalidResponse,
            ),
          ),
        );
      },
    );

    test('never sends when the config is incomplete', () async {
      final transport = FakeAdsHttpTransport();
      final service = AppSupportService(notConfigured, transport: transport);

      await expectLater(
        service.submitErrorReport(description: 'یک مشکل واقعی'),
        throwsA(
          isA<AdsApiException>().having(
            (e) => e.kind,
            'kind',
            AdsErrorKind.notConfigured,
          ),
        ),
      );
      expect(transport.requests, isEmpty);
    });
  });

  group('AppSupportService.submitAdvertisingRequest', () {
    Future<void> submitValid(FakeAdsHttpTransport transport) {
      final service = AppSupportService(configured, transport: transport);
      return service.submitAdvertisingRequest(
        fullName: 'علی رضایی',
        phoneNumber: '09123456789',
        province: 'تهران',
        city: 'تهران',
        details: 'می‌خواهم تبلیغ کنم',
      );
    }

    test('sends every field, trimmed, in the JSON body', () async {
      final transport = FakeAdsHttpTransport()
        ..defaultResponse = jsonResponse(201, {
          'id': 'r2',
          'type': 'AdvertisingRequest',
          'status': 'New',
        });

      await submitValid(transport);

      final request = transport.requests.single;
      expect(request.body, contains('"fullName":"علی رضایی"'));
      expect(request.body, contains('"phoneNumber":"09123456789"'));
      expect(request.body, contains('"province":"تهران"'));
      expect(request.body, contains('"city":"تهران"'));
      expect(request.body, contains('"details":"می‌خواهم تبلیغ کنم"'));
    });

    test('omits details entirely when left blank', () async {
      final transport = FakeAdsHttpTransport()
        ..defaultResponse = jsonResponse(201, {
          'id': 'r3',
          'type': 'AdvertisingRequest',
          'status': 'New',
        });
      final service = AppSupportService(configured, transport: transport);

      await service.submitAdvertisingRequest(
        fullName: 'علی رضایی',
        phoneNumber: '09123456789',
        province: 'تهران',
        city: 'تهران',
        details: '   ',
      );

      expect(transport.requests.single.body, isNot(contains('"details"')));
    });

    test('accepts Persian digits in the phone number', () async {
      final transport = FakeAdsHttpTransport()
        ..defaultResponse = jsonResponse(201, {
          'id': 'r4',
          'type': 'AdvertisingRequest',
          'status': 'New',
        });
      final service = AppSupportService(configured, transport: transport);

      await service.submitAdvertisingRequest(
        fullName: 'علی رضایی',
        phoneNumber: '۰۹۱۲۳۴۵۶۷۸۹',
        province: 'تهران',
        city: 'تهران',
        details: '',
      );

      expect(transport.requests, hasLength(1));
    });

    test('rejects a phone number with too few digits', () async {
      final transport = FakeAdsHttpTransport();
      final service = AppSupportService(configured, transport: transport);

      await expectLater(
        service.submitAdvertisingRequest(
          fullName: 'علی رضایی',
          phoneNumber: '123',
          province: 'تهران',
          city: 'تهران',
          details: '',
        ),
        throwsA(isA<AdsApiException>()),
      );
      expect(transport.requests, isEmpty);
    });

    test('rejects a full name shorter than 3 characters', () async {
      final transport = FakeAdsHttpTransport();
      final service = AppSupportService(configured, transport: transport);

      await expectLater(
        service.submitAdvertisingRequest(
          fullName: 'ع',
          phoneNumber: '09123456789',
          province: 'تهران',
          city: 'تهران',
          details: '',
        ),
        throwsA(isA<AdsApiException>()),
      );
      expect(transport.requests, isEmpty);
    });

    test('rejects a missing province or city', () async {
      final transport = FakeAdsHttpTransport();
      final service = AppSupportService(configured, transport: transport);

      await expectLater(
        service.submitAdvertisingRequest(
          fullName: 'علی رضایی',
          phoneNumber: '09123456789',
          province: '',
          city: 'تهران',
          details: '',
        ),
        throwsA(isA<AdsApiException>()),
      );
    });
  });
}
