import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/persian_digits.dart';
import '../domain/troubleshooting_symptom.dart';

class TroubleshootingDetailPage extends StatelessWidget {
  const TroubleshootingDetailPage({super.key, required this.symptomId});

  final String symptomId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TroubleshootingSymptom? symptom;
    for (final candidate in troubleshootingSymptoms) {
      if (candidate.id == symptomId) {
        symptom = candidate;
        break;
      }
    }

    if (symptom == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('عیب‌یابی اولیه')),
        body: const Center(child: Text('این مورد پیدا نشد.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(symptom.title)),
      body: ListView(
        padding: AppSpacing.page(context),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(AppSpacing.sm),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.onErrorContainer,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'این موارد بررسی‌های اولیه و عمومی‌اند، نه تشخیص قطعی. در '
                    'صورت هرگونه بو، دود یا صدای غیرعادی، فوراً خودرو را '
                    'متوقف و با امداد خودرو یا تعمیرگاه تماس بگیرید.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (var i = 0; i < symptom.steps.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      toPersianDigits('${i + 1}'),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      symptom.steps[i],
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
