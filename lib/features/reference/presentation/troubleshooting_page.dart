import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../domain/troubleshooting_symptom.dart';

/// Symptom picker for the basic troubleshooting guide — a safe, generic
/// first-checks list, never a real diagnosis (see [TroubleshootingSymptom]).
class TroubleshootingPage extends StatelessWidget {
  const TroubleshootingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('عیب‌یابی اولیه')),
      body: ListView(
        padding: AppSpacing.page(context),
        children: [
          AppCard(
            child: Text(
              'این راهنما فقط چند بررسی اولیه و عمومی پیشنهاد می‌دهد و '
              'جایگزین بازدید تعمیرکار نیست. در صورت مشاهده بو، دود یا صدای '
              'غیرعادی، فوراً خودرو را متوقف کنید.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final symptom in troubleshootingSymptoms)
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: Icon(symptom.icon, color: theme.colorScheme.primary),
                title: Text(symptom.title),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(
                  AppRoutes.troubleshootingDetail(symptom.id),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
