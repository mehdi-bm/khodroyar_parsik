import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/widgets/checklist_view.dart';

const _sections = [
  ChecklistSection('بخش یک', [ChecklistItem('مورد ۱'), ChecklistItem('مورد ۲')]),
  ChecklistSection('بخش دو', [ChecklistItem('مورد ۳')]),
];

void main() {
  Widget wrap({Widget? footer}) => MaterialApp(
    home: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ChecklistView(sections: _sections, footer: footer),
      ),
    ),
  );

  testWidgets('starts with progress at 0 of the total item count', (
    tester,
  ) async {
    await tester.pumpWidget(wrap());

    expect(find.text('۰ از ۳'), findsOneWidget);
  });

  testWidgets('checking an item updates the progress count', (tester) async {
    await tester.pumpWidget(wrap());

    await tester.tap(find.text('مورد ۱'));
    await tester.pump();

    expect(find.text('۱ از ۳'), findsOneWidget);
  });

  testWidgets('reset clears every checked item back to 0', (tester) async {
    await tester.pumpWidget(wrap());

    await tester.tap(find.text('مورد ۱'));
    await tester.tap(find.text('مورد ۳'));
    await tester.pump();
    expect(find.text('۲ از ۳'), findsOneWidget);

    await tester.tap(find.text('شروع دوباره'));
    await tester.pump();

    expect(find.text('۰ از ۳'), findsOneWidget);
  });

  testWidgets('renders an optional footer', (tester) async {
    await tester.pumpWidget(wrap(footer: const Text('یادداشت من')));

    expect(find.text('یادداشت من'), findsOneWidget);
  });
}
