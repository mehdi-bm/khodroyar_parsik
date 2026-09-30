import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/reference/presentation/used_car_checklist_page.dart';

void main() {
  testWidgets('shows every checklist section and the notes field', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: UsedCarChecklistPage(),
        ),
      ),
    );

    for (final section in [
      'بدنه و رنگ',
      'موتور',
      'گیربکس و کلاچ',
      'زیربندی و تعلیق',
      'داخل کابین و برق',
      'مدارک',
      'تست رانندگی',
    ]) {
      await tester.scrollUntilVisible(
        find.text(section),
        300,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text(section), findsOneWidget);
    }

    await tester.scrollUntilVisible(
      find.text('یادداشت کلی (اختیاری)'),
      300,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('یادداشت کلی (اختیاری)'), findsOneWidget);
  });
}
