import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/other_apps/domain/parsik_app.dart';
import 'package:caryar/features/other_apps/presentation/other_apps_page.dart';

void main() {
  test('the list never includes this app itself', () {
    expect(
      kOtherParsikApps.map((app) => app.packageName),
      isNot(contains(kOwnPackageName)),
    );
    expect(kOtherParsikApps.length, kParsikApps.length - 1);
  });

  test('package names are unique', () {
    final names = kParsikApps.map((app) => app.packageName).toList();
    expect(names.toSet().length, names.length);
  });

  test('every listed app has a bundled icon', () {
    for (final app in kOtherParsikApps) {
      expect(
        File(app.iconAsset).existsSync(),
        isTrue,
        reason: 'missing ${app.iconAsset}',
      );
    }
  });

  test('links point at the app\'s Bazaar page', () {
    const app = ParsikApp(name: 'x', packageName: 'com.example.app');
    expect(app.bazaarAppUri.toString(), 'bazaar://details?id=com.example.app');
    expect(
      app.bazaarWebUri.toString(),
      'https://cafebazaar.ir/app/com.example.app',
    );
  });

  for (final scale in [1.0, 1.5]) {
    testWidgets('lists every other app without overflow at text scale $scale', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(scale)),
            child: const Directionality(
              textDirection: TextDirection.rtl,
              child: OtherAppsPage(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('سایر اپلیکیشن‌های کاربردی'), findsOneWidget);
      final firstApp = kOtherParsikApps.first;
      expect(find.text(firstApp.name), findsOneWidget);

      final lastApp = kOtherParsikApps.last;
      await tester.scrollUntilVisible(
        find.byKey(Key('other_app_${lastApp.packageName}')),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(lastApp.name), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
