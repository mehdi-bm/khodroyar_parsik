import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/reference/presentation/pretrip_checklist_page.dart';

void main() {
  testWidgets('shows every checklist section', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: PretripChecklistPage(),
        ),
      ),
    );

    for (final section in [
      'روغن و مایعات',
      'لاستیک و زاپاس',
      'چراغ‌ها و برف‌پاک‌کن',
      'ایمنی',
    ]) {
      await tester.scrollUntilVisible(
        find.text(section),
        200,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text(section), findsOneWidget);
    }
  });
}
