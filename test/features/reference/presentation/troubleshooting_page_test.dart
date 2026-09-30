import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/reference/domain/troubleshooting_symptom.dart';
import 'package:caryar/features/reference/presentation/troubleshooting_page.dart';

void main() {
  testWidgets('lists every symptom title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: TroubleshootingPage(),
        ),
      ),
    );

    for (final symptom in troubleshootingSymptoms) {
      await tester.scrollUntilVisible(
        find.text(symptom.title),
        200,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text(symptom.title), findsOneWidget);
    }
  });
}
