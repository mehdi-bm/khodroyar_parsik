import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/di/service_locator.dart';
import 'package:caryar/features/advertising/data/ads_exceptions.dart';
import 'package:caryar/features/advertising/data/app_support_gateway.dart';
import 'package:caryar/features/advertising/presentation/error_report_page.dart';

import '../../../support/fake_app_support_gateway.dart';

Widget _wrap() {
  return const MaterialApp(
    home: Directionality(
      textDirection: TextDirection.rtl,
      child: ErrorReportPage(),
    ),
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

    expect(find.byKey(const ValueKey('error_description')), findsNothing);
    expect(find.text('این قابلیت در حال حاضر در دسترس نیست.'), findsOneWidget);
  });

  testWidgets('rejects a description shorter than 5 characters', (
    tester,
  ) async {
    final gateway = FakeAppSupportGateway();
    getIt.registerLazySingleton<AppSupportGateway>(() => gateway);

    await tester.pumpWidget(_wrap());
    await tester.enterText(
      find.byKey(const ValueKey('error_description')),
      'کم',
    );
    await tester.tap(find.byKey(const ValueKey('submit_error_report')));
    await tester.pumpAndSettle();

    expect(gateway.errorReportDescriptions, isEmpty);
    expect(find.text('شرح خطا باید حداقل ۵ کاراکتر باشد'), findsOneWidget);
  });

  testWidgets(
    'submits successfully, clears the field, and shows a success message',
    (tester) async {
      final gateway = FakeAppSupportGateway();
      final completer = Completer<void>();
      gateway.beforeReturns = () => completer.future;
      getIt.registerLazySingleton<AppSupportGateway>(() => gateway);

      await tester.pumpWidget(_wrap());
      await tester.enterText(
        find.byKey(const ValueKey('error_description')),
        'صفحه سوخت باز نمی‌شود و برنامه بسته می‌شود',
      );
      await tester.tap(find.byKey(const ValueKey('submit_error_report')));
      await tester.pump();

      // Button disabled / shows a spinner while submitting — held open by
      // the completer so this is reliably observable.
      expect(
        tester
            .widget<ElevatedButton>(
              find.byKey(const ValueKey('submit_error_report')),
            )
            .onPressed,
        isNull,
      );

      completer.complete();
      await tester.pumpAndSettle();

      expect(gateway.errorReportDescriptions, hasLength(1));
      expect(
        find.text('گزارش شما ثبت شد؛ سپاس از همراهی شما.'),
        findsOneWidget,
      );

      final field = tester.widget<TextFormField>(
        find.byKey(const ValueKey('error_description')),
      );
      expect(field.controller?.text, isEmpty);
    },
  );

  testWidgets('keeps the entered text and re-enables the button on failure', (
    tester,
  ) async {
    final gateway = FakeAppSupportGateway()
      ..errorReportError = const AdsApiException(AdsErrorKind.server);
    getIt.registerLazySingleton<AppSupportGateway>(() => gateway);

    await tester.pumpWidget(_wrap());
    await tester.enterText(
      find.byKey(const ValueKey('error_description')),
      'صفحه سوخت باز نمی‌شود و برنامه بسته می‌شود',
    );
    await tester.tap(find.byKey(const ValueKey('submit_error_report')));
    await tester.pumpAndSettle();

    expect(
      find.text('خطایی در سرور رخ داد؛ کمی بعد دوباره تلاش کنید.'),
      findsOneWidget,
    );
    final field = tester.widget<TextFormField>(
      find.byKey(const ValueKey('error_description')),
    );
    expect(field.controller?.text, isNotEmpty);
    expect(
      tester
          .widget<ElevatedButton>(
            find.byKey(const ValueKey('submit_error_report')),
          )
          .onPressed,
      isNotNull,
    );
  });
}
