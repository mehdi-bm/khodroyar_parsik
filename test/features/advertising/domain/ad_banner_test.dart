import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/advertising/data/ads_config.dart';
import 'package:caryar/features/advertising/domain/ad_banner.dart';

void main() {
  const config = AdsConfig(
    baseUrl: 'https://ads.parsikonline.ir/',
    apiKey: 'k',
    externalAppApiKey: 'k2',
    appName: 'parsik_khodroyar',
    platform: 'Android',
    sectionCode: '',
  );

  group('AdBanner.tryParse', () {
    test('parses a fully-populated item', () {
      final banner = AdBanner.tryParse({
        'bannerId': 'b1',
        'bannerTitle': ' عنوان ',
        'imageUrl': '/uploads/a.webp',
        'destinationUrl': 'https://example.com/landing',
        'campaignTitle': 'کمپین',
        'sectionName': 'صفحه اصلی',
        'sectionCode': 'home-main',
      }, config);

      expect(banner, isNotNull);
      expect(banner!.bannerId, 'b1');
      expect(banner.bannerTitle, 'عنوان');
      expect(
        banner.imageUrl.toString(),
        'https://ads.parsikonline.ir/uploads/a.webp',
      );
    });

    test('returns null when bannerId is missing', () {
      final banner = AdBanner.tryParse({
        'imageUrl': 'https://example.com/a.webp',
        'destinationUrl': 'https://example.com/a',
      }, config);
      expect(banner, isNull);
    });

    test('returns null when bannerId is an empty/whitespace string', () {
      final banner = AdBanner.tryParse({
        'bannerId': '   ',
        'imageUrl': 'https://example.com/a.webp',
        'destinationUrl': 'https://example.com/a',
      }, config);
      expect(banner, isNull);
    });

    test('returns null when imageUrl is missing', () {
      final banner = AdBanner.tryParse({
        'bannerId': 'b1',
        'destinationUrl': 'https://example.com/a',
      }, config);
      expect(banner, isNull);
    });

    test('returns null when destinationUrl is missing', () {
      final banner = AdBanner.tryParse({
        'bannerId': 'b1',
        'imageUrl': 'https://example.com/a.webp',
      }, config);
      expect(banner, isNull);
    });

    test('returns null when a URL uses a disallowed scheme', () {
      final banner = AdBanner.tryParse({
        'bannerId': 'b1',
        'imageUrl': 'javascript:alert(1)',
        'destinationUrl': 'https://example.com/a',
      }, config);
      expect(banner, isNull);
    });

    test('tolerantly defaults optional string fields to empty', () {
      final banner = AdBanner.tryParse({
        'bannerId': 'b1',
        'imageUrl': 'https://example.com/a.webp',
        'destinationUrl': 'https://example.com/a',
      }, config);
      expect(banner, isNotNull);
      expect(banner!.bannerTitle, '');
      expect(banner.campaignTitle, '');
      expect(banner.sectionName, '');
      expect(banner.sectionCode, '');
    });
  });
}
