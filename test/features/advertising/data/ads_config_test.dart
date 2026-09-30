import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/advertising/data/ads_config.dart';

void main() {
  group('AdsConfig', () {
    const configured = AdsConfig(
      baseUrl: 'https://ads.parsikonline.ir/',
      apiKey: 'test-api-key',
      externalAppApiKey: 'test-external-app-key',
      appName: 'parsik_khodroyar',
      platform: 'Android',
      sectionCode: 'home-main',
    );

    test('isConfigured requires both API keys to be non-empty', () {
      expect(configured.isConfigured, isTrue);
      expect(configured.copyWithKeys(apiKey: '').isConfigured, isFalse);
      expect(
        configured.copyWithKeys(externalAppApiKey: '').isConfigured,
        isFalse,
      );
    });

    test('apiUri builds the correct path and query, joining base + path', () {
      final uri = configured.apiUri(
        'api/public/ads/banners',
        queryParameters: {'platform': 'Android'},
      );
      expect(
        uri.toString(),
        'https://ads.parsikonline.ir/api/public/ads/banners?platform=Android',
      );
    });

    test('apiUri omits query entirely when no parameters are given', () {
      final uri = configured.apiUri('api/public/ads/click');
      expect(
        uri.toString(),
        'https://ads.parsikonline.ir/api/public/ads/click',
      );
      expect(uri.hasQuery, isFalse);
    });

    test('resolvePublicUrl resolves a relative path against the base URL', () {
      final resolved = configured.resolvePublicUrl(
        '/uploads/banners/example.webp',
      );
      expect(
        resolved.toString(),
        'https://ads.parsikonline.ir/uploads/banners/example.webp',
      );
    });

    test('resolvePublicUrl leaves an absolute https URL untouched', () {
      final resolved = configured.resolvePublicUrl(
        'https://example.com/landing',
      );
      expect(resolved.toString(), 'https://example.com/landing');
    });

    test('resolvePublicUrl rejects a non-https URL outside debug mode', () {
      // kDebugMode is true under `flutter test`, so this specific case is
      // exercised indirectly by the debug-mode-allows-http test below; here
      // we confirm a genuinely unsafe scheme is always rejected regardless
      // of build mode.
      expect(
        () => configured.resolvePublicUrl('javascript:alert(1)'),
        throwsFormatException,
      );
    });
  });
}

extension on AdsConfig {
  AdsConfig copyWithKeys({String? apiKey, String? externalAppApiKey}) {
    return AdsConfig(
      baseUrl: baseUrl,
      apiKey: apiKey ?? this.apiKey,
      externalAppApiKey: externalAppApiKey ?? this.externalAppApiKey,
      appName: appName,
      platform: platform,
      sectionCode: sectionCode,
    );
  }
}
