import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/advertising/data/ads_config.dart';
import 'package:caryar/features/advertising/data/ads_exceptions.dart';
import 'package:caryar/features/advertising/data/ads_http_transport.dart';
import 'package:caryar/features/advertising/data/advertising_service.dart';

import '../../../support/fake_ads_http_transport.dart';

void main() {
  const configuredWithSection = AdsConfig(
    baseUrl: 'https://ads.parsikonline.ir/',
    apiKey: 'test-api-key',
    externalAppApiKey: 'test-external-key',
    appName: 'parsik_khodroyar',
    platform: 'Android',
    sectionCode: 'home-main',
  );
  const configuredNoSection = AdsConfig(
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

  group('AdvertisingService.fetchBanners', () {
    test('sends both API-key headers and platform+sectionCode query', () async {
      final transport = FakeAdsHttpTransport()
        ..defaultResponse = jsonResponse(200, <Object?>[]);
      final service = AdvertisingService(
        configuredWithSection,
        transport: transport,
      );

      await service.fetchBanners();

      final request = transport.requests.single;
      expect(request.method, 'GET');
      expect(request.url.queryParameters['platform'], 'Android');
      expect(request.url.queryParameters['sectionCode'], 'home-main');
      expect(request.headers['X-API-KEY'], 'test-api-key');
      expect(request.headers['X-EXTERNAL-APP-API-KEY'], 'test-external-key');
    });

    test('omits sectionCode from the query when it is empty', () async {
      final transport = FakeAdsHttpTransport()
        ..defaultResponse = jsonResponse(200, <Object?>[]);
      final service = AdvertisingService(
        configuredNoSection,
        transport: transport,
      );

      await service.fetchBanners();

      final request = transport.requests.single;
      expect(request.url.queryParameters.containsKey('sectionCode'), isFalse);
    });

    test(
      'parses a full banner list and resolves relative image URLs',
      () async {
        final transport = FakeAdsHttpTransport()
          ..defaultResponse = jsonResponse(200, [
            {
              'bannerId': 'b1',
              'bannerTitle': 'عنوان بنر',
              'imageUrl': '/uploads/banners/example.webp',
              'destinationUrl': 'https://example.com/landing',
              'campaignTitle': 'کمپین',
              'sectionName': 'صفحه اصلی',
              'sectionCode': 'home-main',
            },
          ]);
        final service = AdvertisingService(
          configuredWithSection,
          transport: transport,
        );

        final banners = await service.fetchBanners();

        expect(banners, hasLength(1));
        expect(banners.single.bannerId, 'b1');
        expect(
          banners.single.imageUrl.toString(),
          'https://ads.parsikonline.ir/uploads/banners/example.webp',
        );
        expect(
          banners.single.destinationUrl.toString(),
          'https://example.com/landing',
        );
      },
    );

    test('drops items missing a bannerId instead of throwing', () async {
      final transport = FakeAdsHttpTransport()
        ..defaultResponse = jsonResponse(200, [
          {
            'imageUrl': 'https://example.com/a.webp',
            'destinationUrl': 'https://example.com/a',
          },
          {
            'bannerId': 'ok',
            'imageUrl': 'https://example.com/b.webp',
            'destinationUrl': 'https://example.com/b',
          },
        ]);
      final service = AdvertisingService(
        configuredWithSection,
        transport: transport,
      );

      final banners = await service.fetchBanners();

      expect(banners, hasLength(1));
      expect(banners.single.bannerId, 'ok');
    });

    test(
      'an empty successful response yields an empty list, not an error',
      () async {
        final transport = FakeAdsHttpTransport()
          ..defaultResponse = emptyResponse(200);
        final service = AdvertisingService(
          configuredWithSection,
          transport: transport,
        );

        expect(await service.fetchBanners(), isEmpty);
      },
    );

    test('never sends a request when the config is incomplete', () async {
      final transport = FakeAdsHttpTransport();
      final service = AdvertisingService(notConfigured, transport: transport);

      await expectLater(
        service.fetchBanners(),
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

    for (final entry in {
      400: AdsErrorKind.validation,
      401: AdsErrorKind.auth,
      403: AdsErrorKind.auth,
      429: AdsErrorKind.rateLimited,
      500: AdsErrorKind.server,
    }.entries) {
      test('maps HTTP ${entry.key} to ${entry.value.name}', () async {
        final transport = FakeAdsHttpTransport()
          ..defaultResponse = emptyResponse(entry.key);
        final service = AdvertisingService(
          configuredWithSection,
          transport: transport,
        );

        await expectLater(
          service.fetchBanners(),
          throwsA(
            isA<AdsApiException>().having((e) => e.kind, 'kind', entry.value),
          ),
        );
      });
    }

    test(
      'malformed JSON is reported as an invalid response, not a crash',
      () async {
        final transport = FakeAdsHttpTransport()
          ..defaultResponse = const AdsHttpResponse(
            statusCode: 200,
            bodyBytes: [0x7b, 0x6e, 0x6f, 0x74, 0x2d, 0x6a, 0x73, 0x6f, 0x6e],
          ); // "{not-json"
        final service = AdvertisingService(
          configuredWithSection,
          transport: transport,
        );

        await expectLater(
          service.fetchBanners(),
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

    test('a transport-level timeout is reported as a network error', () async {
      final transport = FakeAdsHttpTransport()
        ..responder = (_) =>
            throw const AdsTransportException(AdsErrorKind.network);
      final service = AdvertisingService(
        configuredWithSection,
        transport: transport,
      );

      await expectLater(
        service.fetchBanners(),
        throwsA(
          isA<AdsApiException>().having(
            (e) => e.kind,
            'kind',
            AdsErrorKind.network,
          ),
        ),
      );
    });
  });

  group('AdvertisingService.registerClick', () {
    test('sends the full documented payload', () async {
      final transport = FakeAdsHttpTransport()
        ..defaultResponse = jsonResponse(201, {
          'clickId': 'c1',
          'bannerId': 'b1',
          'destinationUrl': 'https://example.com/landing',
        });
      final service = AdvertisingService(
        configuredWithSection,
        transport: transport,
      );

      await service.registerClick(bannerId: 'b1', externalUserId: 'abc123');

      final request = transport.requests.single;
      expect(request.method, 'POST');
      expect(request.headers['Content-Type'], contains('application/json'));
      expect(request.body, contains('"bannerId":"b1"'));
      expect(request.body, contains('"externalUserId":"abc123"'));
      expect(request.body, contains('"appName":"parsik_khodroyar"'));
      expect(request.body, contains('"platform":"Android"'));
      expect(
        request.body,
        contains(
          '"referrerUrl":"https://parsikhesab.com/apps/parsik_khodroyar/ads/b1"',
        ),
      );
    });

    test('parses destinationUrl from the 201 response', () async {
      final transport = FakeAdsHttpTransport()
        ..defaultResponse = jsonResponse(201, {
          'clickId': 'c1',
          'destinationUrl': 'https://example.com/landing',
        });
      final service = AdvertisingService(
        configuredWithSection,
        transport: transport,
      );

      final destination = await service.registerClick(
        bannerId: 'b1',
        externalUserId: 'abc123',
      );

      expect(destination.toString(), 'https://example.com/landing');
    });

    test('a 429 maps to the rate-limited error', () async {
      final transport = FakeAdsHttpTransport()
        ..defaultResponse = emptyResponse(429);
      final service = AdvertisingService(
        configuredWithSection,
        transport: transport,
      );

      await expectLater(
        service.registerClick(bannerId: 'b1', externalUserId: 'u1'),
        throwsA(
          isA<AdsApiException>().having(
            (e) => e.kind,
            'kind',
            AdsErrorKind.rateLimited,
          ),
        ),
      );
    });
  });

  test('no exception message ever contains the configured API keys', () {
    for (final kind in AdsErrorKind.values) {
      final message = AdsApiException(kind).message;
      expect(message.contains(configuredWithSection.apiKey), isFalse);
      expect(
        message.contains(configuredWithSection.externalAppApiKey),
        isFalse,
      );
    }
  });
}
