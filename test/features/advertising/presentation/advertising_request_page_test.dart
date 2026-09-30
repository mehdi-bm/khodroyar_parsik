import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/di/service_locator.dart';
import 'package:caryar/features/advertising/data/app_support_gateway.dart';
import 'package:caryar/features/advertising/presentation/advertising_request_page.dart';

import '../../../support/fake_app_support_gateway.dart';

Widget _wrap({Size size = const Size(400, 800)}) {
  return MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(size: size),
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: AdvertisingRequestPage(),
      ),
    ),
  );
}

Future<void> _fillValidForm(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const ValueKey('advertising_full_name')),
    'علی رضایی',
  );
  await tester.enterText(
    find.byKey(const ValueKey('advertising_phone')),
    '09123456789',
  );
  await tester.enterText(
    find.byKey(const ValueKey('advertising_province')),
    'تهران',
  );
  await tester.enterText(
    find.byKey(const ValueKey('advertising_city')),
    'تهران',
  );
}

void main() {
  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('shows a disabled notice when the feature is not configured', (
    tester,
  ) async {
    getIt.registerLazySingleton<AppSupportGateway>(
      () => FakeAppSupportGateway(configured: false),
    );

    await tester.pumpWidget(_wrap());

    expect(find.byKey(const ValueKey('advertising_full_name')), findsNothing);
    expect(find.text('این قابلیت در حال حاضر در دسترس نیست.'), findsOneWidget);
  });

  testWidgets('validates every required field', (tester) async {
    final gateway = FakeAppSupportGateway();
    getIt.registerLazySingleton<AppSupportGateway>(() => gateway);

    await tester.pumpWidget(_wrap());
    await tester.tap(find.byKey(const ValueKey('submit_advertising_request')));
    await tester.pumpAndSettle();

    expect(gateway.advertisingRequests, isEmpty);
    expect(
      find.text('وارد کردن نام و نام خانوادگی الزامی است'),
      findsOneWidget,
    );
    expect(find.text('وارد کردن شماره تماس الزامی است'), findsOneWidget);
    expect(find.text('وارد کردن استان الزامی است'), findsOneWidget);
    expect(find.text('وارد کردن شهر الزامی است'), findsOneWidget);
  });

  testWidgets('accepts a Persian-digit phone number', (tester) async {
    final gateway = FakeAppSupportGateway();
    getIt.registerLazySingleton<AppSupportGateway>(() => gateway);

    await tester.pumpWidget(_wrap());
    await tester.enterText(
      find.byKey(const ValueKey('advertising_full_name')),
      'علی رضایی',
    );
    await tester.enterText(
      find.byKey(const ValueKey('advertising_phone')),
      '۰۹۱۲۳۴۵۶۷۸۹',
    );
    await tester.enterText(
      find.byKey(const ValueKey('advertising_province')),
      'تهران',
    );
    await tester.enterText(
      find.byKey(const ValueKey('advertising_city')),
      'تهران',
    );
    await tester.tap(find.byKey(const ValueKey('submit_advertising_request')));
    await tester.pumpAndSettle();

    expect(gateway.advertisingRequests, hasLength(1));
  });

  testWidgets(
    'submits all fields, clears the form, and shows a success message',
    (tester) async {
      final gateway = FakeAppSupportGateway();
      getIt.registerLazySingleton<AppSupportGateway>(() => gateway);

      await tester.pumpWidget(_wrap());
      await _fillValidForm(tester);
      await tester.enterText(
        find.byKey(const ValueKey('advertising_details')),
        'می‌خواهم تبلیغ کنم',
      );
      await tester.tap(
        find.byKey(const ValueKey('submit_advertising_request')),
      );
      await tester.pumpAndSettle();

      expect(gateway.advertisingRequests, hasLength(1));
      final request = gateway.advertisingRequests.single;
      expect(request['fullName'], 'علی رضایی');
      expect(request['phoneNumber'], '09123456789');
      expect(request['province'], 'تهران');
      expect(request['city'], 'تهران');
      expect(request['details'], 'می‌خواهم تبلیغ کنم');

      expect(
        find.textContaining('کارشناسان تبلیغات پارسیک با شماره ثبت‌شده'),
        findsOneWidget,
      );

      final nameField = tester.widget<TextFormField>(
        find.byKey(const ValueKey('advertising_full_name')),
      );
      expect(nameField.controller?.text, isEmpty);
    },
  );

  testWidgets('keeps entered values on a submission failure', (tester) async {
    final gateway = FakeAppSupportGateway()
      ..advertisingRequestError = Exception('network down');
    getIt.registerLazySingleton<AppSupportGateway>(() => gateway);

    await tester.pumpWidget(_wrap());
    await _fillValidForm(tester);
    await tester.tap(find.byKey(const ValueKey('submit_advertising_request')));
    await tester.pumpAndSettle();

    final nameField = tester.widget<TextFormField>(
      find.byKey(const ValueKey('advertising_full_name')),
    );
    expect(nameField.controller?.text, 'علی رضایی');
  });

  testWidgets('shows the privacy notice', (tester) async {
    getIt.registerLazySingleton<AppSupportGateway>(FakeAppSupportGateway.new);

    await tester.pumpWidget(_wrap());

    expect(
      find.text('اطلاعات شما فقط برای پیگیری همین درخواست استفاده می‌شود.'),
      findsOneWidget,
    );
  });

  testWidgets('lays out province/city without overflow on a small phone', (
    tester,
  ) async {
    getIt.registerLazySingleton<AppSupportGateway>(FakeAppSupportGateway.new);

    await tester.pumpWidget(_wrap(size: const Size(320, 640)));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'lays out province/city side by side without overflow on a wide screen',
    (tester) async {
      getIt.registerLazySingleton<AppSupportGateway>(FakeAppSupportGateway.new);

      await tester.pumpWidget(_wrap(size: const Size(900, 700)));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    },
  );
}
