import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/widgets/status_badge.dart';
import 'package:caryar/features/documents/domain/document_status_calculator.dart';

void main() {
  final today = DateTime(2026, 1, 1);

  group('computeDocumentStatus', () {
    test(
      'good when far from expiring (matches the spec: 120 days -> good)',
      () {
        final status = computeDocumentStatus(
          expirationDate: today.add(const Duration(days: 120)),
          today: today,
        );
        expect(status, AppStatusLevel.good);
      },
    );

    test('upcoming within 90 days (matches the spec: 84 days -> upcoming)', () {
      final status = computeDocumentStatus(
        expirationDate: today.add(const Duration(days: 84)),
        today: today,
      );
      expect(status, AppStatusLevel.upcoming);
    });

    test('due within 14 days', () {
      final status = computeDocumentStatus(
        expirationDate: today.add(const Duration(days: 10)),
        today: today,
      );
      expect(status, AppStatusLevel.due);
    });

    test('overdue once expired', () {
      final status = computeDocumentStatus(
        expirationDate: today.subtract(const Duration(days: 1)),
        today: today,
      );
      expect(status, AppStatusLevel.overdue);
    });

    test('overdue on the exact expiration day', () {
      final status = computeDocumentStatus(expirationDate: today, today: today);
      expect(status, AppStatusLevel.overdue);
    });
  });

  group('describeDocumentRemaining', () {
    test('describes remaining days', () {
      final text = describeDocumentRemaining(
        expirationDate: today.add(const Duration(days: 84)),
        today: today,
      );
      expect(text, '۸۴ روز باقی‌مانده');
    });

    test('describes an expired document', () {
      final text = describeDocumentRemaining(
        expirationDate: today.subtract(const Duration(days: 5)),
        today: today,
      );
      expect(text, '۵ روز منقضی شده');
    });
  });
}
