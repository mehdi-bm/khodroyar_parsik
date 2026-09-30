import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/reference/domain/troubleshooting_symptom.dart';
import 'package:caryar/features/reference/presentation/troubleshooting_detail_page.dart';

void main() {
  Widget wrap(String symptomId) => MaterialApp(
    home: Directionality(
      textDirection: TextDirection.rtl,
      child: TroubleshootingDetailPage(symptomId: symptomId),
    ),
  );

  testWidgets('shows every step and the mechanic disclaimer', (tester) async {
    final symptom = troubleshootingSymptoms.first;
    await tester.pumpWidget(wrap(symptom.id));

    expect(find.text(symptom.title), findsOneWidget);
    for (final step in symptom.steps) {
      expect(find.text(step), findsOneWidget);
    }
    expect(find.text('۱'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    expect(
      find.textContaining('فوراً خودرو را متوقف و با امداد خودرو یا تعمیرگاه'),
      findsOneWidget,
    );
  });

  testWidgets('shows a not-found message for an unknown id', (tester) async {
    await tester.pumpWidget(wrap('does-not-exist'));

    expect(find.text('این مورد پیدا نشد.'), findsOneWidget);
  });
}
