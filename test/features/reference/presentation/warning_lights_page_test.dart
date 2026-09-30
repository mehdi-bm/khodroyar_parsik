import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/theme/app_theme.dart';
import 'package:caryar/features/reference/domain/warning_light.dart';
import 'package:caryar/features/reference/presentation/warning_lights_page.dart';

void main() {
  Widget wrap() => MaterialApp(
    theme: AppTheme.light(),
    home: const Directionality(
      textDirection: TextDirection.rtl,
      child: WarningLightsPage(),
    ),
  );

  testWidgets('shows the manufacturer-varies disclaimer', (tester) async {
    await tester.pumpWidget(wrap());
    expect(find.textContaining('دفترچه راهنمای خودروی خود'), findsOneWidget);
  });

  testWidgets('lists every warning light title', (tester) async {
    await tester.pumpWidget(wrap());
    for (final light in warningLights) {
      expect(
        find.text(light.title),
        findsOneWidget,
        reason: 'missing tile for "${light.title}"',
      );
    }
  });

  testWidgets('expanding a tile shows its meaning and action', (
    tester,
  ) async {
    await tester.pumpWidget(wrap());
    final first = warningLights.first;

    expect(find.text(first.meaning), findsNothing);

    await tester.tap(find.text(first.title));
    await tester.pumpAndSettle();

    expect(find.text(first.meaning), findsOneWidget);
    expect(find.text(first.action), findsOneWidget);
  });
}
