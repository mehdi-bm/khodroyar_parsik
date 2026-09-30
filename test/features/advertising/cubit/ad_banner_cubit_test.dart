import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/advertising/cubit/ad_banner_cubit.dart';
import 'package:caryar/features/advertising/domain/ad_banner.dart';

import '../../../support/fake_advertising_gateway.dart';

AdBanner _banner(String id) => AdBanner(
  bannerId: id,
  bannerTitle: 'عنوان $id',
  imageUrl: Uri.parse('https://example.com/$id.png'),
  destinationUrl: Uri.parse('https://example.com/$id'),
  campaignTitle: 'کمپین',
  sectionName: 'صفحه اصلی',
  sectionCode: 'home-main',
);

void main() {
  group('AdBannerCubit.loadInitial / refresh', () {
    test('fetches and populates banners on first load', () async {
      final gateway = FakeAdvertisingGateway()
        ..bannersToReturn = [_banner('a'), _banner('b')];
      final cubit = AdBannerCubit(gateway);

      await cubit.loadInitial();

      expect(cubit.state.initialLoading, isFalse);
      expect(cubit.state.banners, hasLength(2));
      expect(cubit.state.errorMessage, isNull);
      expect(cubit.state.lastSuccessfulFetch, isNotNull);
      await cubit.close();
    });

    test('skips the network entirely when not configured', () async {
      final gateway = FakeAdvertisingGateway(configured: false);
      final cubit = AdBannerCubit(gateway);

      await cubit.loadInitial();

      expect(gateway.fetchCallCount, 0);
      expect(cubit.state.initialLoading, isFalse);
      expect(cubit.state.banners, isEmpty);
      await cubit.close();
    });

    test('a fetch failure surfaces a Persian error message', () async {
      final gateway = FakeAdvertisingGateway()..fetchError = Exception('boom');
      final cubit = AdBannerCubit(gateway);

      await cubit.loadInitial();

      expect(cubit.state.errorMessage, 'دریافت تبلیغات ناموفق بود');
      expect(cubit.state.banners, isEmpty);
      await cubit.close();
    });

    test(
      'a later failed refresh keeps the previously loaded banners',
      () async {
        final gateway = FakeAdvertisingGateway()
          ..bannersToReturn = [_banner('a')];
        final cubit = AdBannerCubit(gateway);
        await cubit.loadInitial();
        expect(cubit.state.banners, hasLength(1));

        gateway.fetchError = Exception('network down');
        await cubit.refresh(force: true);

        expect(cubit.state.banners, hasLength(1));
        expect(cubit.state.errorMessage, isNotNull);
        await cubit.close();
      },
    );

    test('refresh() without force skips a still-fresh cache', () async {
      final gateway = FakeAdvertisingGateway()
        ..bannersToReturn = [_banner('a')];
      final cubit = AdBannerCubit(gateway);
      await cubit.loadInitial();
      expect(gateway.fetchCallCount, 1);

      await cubit.refresh();

      expect(gateway.fetchCallCount, 1);
      await cubit.close();
    });

    test(
      'refresh(force: true) always re-fetches even with a fresh cache',
      () async {
        final gateway = FakeAdvertisingGateway()
          ..bannersToReturn = [_banner('a')];
        final cubit = AdBannerCubit(gateway);
        await cubit.loadInitial();

        await cubit.refresh(force: true);

        expect(gateway.fetchCallCount, 2);
        await cubit.close();
      },
    );

    test('a second concurrent refresh call is de-duplicated', () async {
      final gateway = FakeAdvertisingGateway()
        ..bannersToReturn = [_banner('a')];
      final completer = Completer<void>();
      gateway.beforeFetchReturns = () => completer.future;
      final cubit = AdBannerCubit(gateway);

      final first = cubit.loadInitial();
      final second = cubit.refresh(force: true);
      completer.complete();
      await Future.wait([first, second]);

      expect(gateway.fetchCallCount, 1);
      await cubit.close();
    });
  });

  group('AdBannerCubit.openBanner', () {
    test('registers the click and returns the API destination URL', () async {
      final gateway = FakeAdvertisingGateway()
        ..clickDestination = Uri.parse('https://example.com/real-landing');
      final cubit = AdBannerCubit(gateway);

      final result = await cubit.openBanner(_banner('a'), externalUserId: 'u1');

      expect(result.toString(), 'https://example.com/real-landing');
      expect(gateway.registeredClickBannerIds, ['a']);
      expect(cubit.state.isOpeningLink, isFalse);
      await cubit.close();
    });

    test(
      'falls back to the banner\'s own destination when the click call fails',
      () async {
        final gateway = FakeAdvertisingGateway()
          ..clickError = Exception('network');
        final cubit = AdBannerCubit(gateway);
        final banner = _banner('a');

        final result = await cubit.openBanner(banner, externalUserId: 'u1');

        expect(result, banner.destinationUrl);
        await cubit.close();
      },
    );

    test('ignores a second tap while a click is already in flight', () async {
      final gateway = FakeAdvertisingGateway();
      final cubit = AdBannerCubit(gateway);
      final banner = _banner('a');

      // openBanner's guard reads cubit state synchronously, so the dedupe
      // check is reliable even though the first call hasn't completed yet.
      final firstFuture = cubit.openBanner(banner, externalUserId: 'u1');
      expect(cubit.state.isOpeningLink, isTrue);

      final secondResult = await cubit.openBanner(banner, externalUserId: 'u1');
      expect(secondResult, isNull);

      await firstFuture;
      expect(gateway.registeredClickBannerIds, ['a']);
      await cubit.close();
    });
  });
}
