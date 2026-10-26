import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/di/service_locator.dart';
import 'package:caryar/features/advertising/cubit/ad_banner_cubit.dart';
import 'package:caryar/features/advertising/data/install_id_repository.dart';
import 'package:caryar/features/advertising/domain/ad_banner.dart';
import 'package:caryar/features/advertising/presentation/widgets/ad_banner_strip.dart';

import '../../../../support/fake_advertising_gateway.dart';

class _InMemoryInstallIdStore implements InstallIdStore {
  String? value;

  @override
  Future<String?> read() async => value;

  @override
  Future<void> write(String value) async => this.value = value;
}

AdBanner _banner(String id) => AdBanner(
  bannerId: id,
  bannerTitle: 'عنوان $id',
  imageUrl: Uri.parse('https://example.com/$id.png'),
  destinationUrl: Uri.parse('https://example.com/$id'),
  campaignTitle: 'کمپین $id',
  sectionName: 'صفحه اصلی',
  sectionCode: 'home-main',
);

Widget _wrap(AdBannerCubit cubit) {
  return MaterialApp(
    home: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            const Expanded(child: SizedBox()),
            BlocProvider.value(value: cubit, child: const AdBannerStrip()),
          ],
        ),
      ),
    ),
  );
}

void main() {
  setUp(() {
    getIt.registerLazySingleton<InstallIdRepository>(
      () => InstallIdRepository(store: _InMemoryInstallIdStore()),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('takes no space while the first fetch is pending', (
    tester,
  ) async {
    final gateway = FakeAdvertisingGateway();
    final completer = Completer<void>();
    gateway.beforeFetchReturns = () => completer.future;
    final cubit = AdBannerCubit(gateway)..loadInitial();

    await tester.pumpWidget(_wrap(cubit));
    await tester.pump();

    expect(tester.getSize(find.byType(AdBannerStrip)).height, 0);

    completer.complete();
    await tester.pumpAndSettle();
    await cubit.close();
  });

  testWidgets('renders nothing for an empty successful response', (
    tester,
  ) async {
    final gateway = FakeAdvertisingGateway();
    final cubit = AdBannerCubit(gateway);

    await tester.pumpWidget(_wrap(cubit));
    await cubit.loadInitial();
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(AdBannerStrip)).height, 0);
    await cubit.close();
  });

  testWidgets('stays out of the way on a failed fetch', (tester) async {
    final gateway = FakeAdvertisingGateway()..fetchError = Exception('boom');
    final cubit = AdBannerCubit(gateway);

    await tester.pumpWidget(_wrap(cubit));
    await cubit.loadInitial();
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(AdBannerStrip)).height, 0);
    expect(find.text('دریافت تبلیغات ناموفق بود'), findsNothing);

    // A later successful refresh (pull-to-refresh / app resume) brings it
    // back.
    gateway.fetchError = null;
    gateway.bannersToReturn = [_banner('a')];
    await cubit.refresh(force: true);
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('ad_banner_a')), findsOneWidget);
    await cubit.close();
  });

  testWidgets('shows a single compact banner with its ad label', (
    tester,
  ) async {
    final gateway = FakeAdvertisingGateway()
      ..bannersToReturn = [_banner('a'), _banner('b')];
    final cubit = AdBannerCubit(gateway);

    await tester.pumpWidget(_wrap(cubit));
    await cubit.loadInitial();
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('ad_banner_a')), findsOneWidget);
    expect(find.byKey(const ValueKey('ad_banner_b')), findsNothing);
    expect(find.text('عنوان a'), findsOneWidget);
    expect(find.text('تبلیغ'), findsOneWidget);
    expect(tester.getSize(find.byType(AdBannerStrip)).height, lessThan(80));
    await cubit.close();
  });

  testWidgets('never rotates on its own while visible', (tester) async {
    final gateway = FakeAdvertisingGateway()
      ..bannersToReturn = [_banner('a'), _banner('b')];
    final cubit = AdBannerCubit(gateway);

    await tester.pumpWidget(_wrap(cubit));
    await cubit.loadInitial();
    await tester.pumpAndSettle();

    await tester.pump(const Duration(minutes: 1));

    expect(cubit.state.currentIndex, 0);
    expect(find.byKey(const ValueKey('ad_banner_a')), findsOneWidget);
    await cubit.close();
  });

  testWidgets('shows the next banner when the app returns to foreground', (
    tester,
  ) async {
    final gateway = FakeAdvertisingGateway()
      ..bannersToReturn = [_banner('a'), _banner('b')];
    final cubit = AdBannerCubit(gateway);

    await tester.pumpWidget(_wrap(cubit));
    await cubit.loadInitial();
    await tester.pumpAndSettle();

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('ad_banner_b')), findsOneWidget);
    await cubit.close();
  });

  testWidgets('tapping a banner registers exactly one click', (tester) async {
    final gateway = FakeAdvertisingGateway()
      ..bannersToReturn = [_banner('a')]
      ..clickDestination = Uri.parse('https://example.com/real');
    final cubit = AdBannerCubit(gateway);

    await tester.pumpWidget(_wrap(cubit));
    await cubit.loadInitial();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('ad_banner_a')));
    await tester.pumpAndSettle();

    expect(gateway.registeredClickBannerIds, ['a']);
    await cubit.close();
  });

  testWidgets(
    'the cubit-level dedupe (see ad_banner_cubit_test.dart) means a tap '
    'fired again before the click settles never registers twice — this '
    'test exercises the widget path end-to-end at the state level',
    (tester) async {
      final gateway = FakeAdvertisingGateway()
        ..bannersToReturn = [_banner('a')]
        ..clickDestination = Uri.parse('https://example.com/real');
      final cubit = AdBannerCubit(gateway);

      await tester.pumpWidget(_wrap(cubit));
      await cubit.loadInitial();
      await tester.pumpAndSettle();

      final firstTap = cubit.openBanner(_banner('a'), externalUserId: 'u1');
      expect(cubit.state.isOpeningLink, isTrue);
      final secondTap = cubit.openBanner(_banner('a'), externalUserId: 'u1');

      await Future.wait([firstTap, secondTap]);
      expect(gateway.registeredClickBannerIds, ['a']);
      await cubit.close();
    },
  );
}
