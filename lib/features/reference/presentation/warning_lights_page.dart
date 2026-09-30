import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../domain/warning_light.dart';

/// A general reference guide to common dashboard warning lights — not
/// manufacturer-specific, and not a substitute for the vehicle's own
/// manual or a mechanic's diagnosis (both stated up front on the page).
class WarningLightsPage extends StatelessWidget {
  const WarningLightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('راهنمای چراغ‌های آمپر')),
      body: SingleChildScrollView(
        padding: AppSpacing.page(context),
        // This is a short, fully-static reference list (~20 items) — a
        // plain Column inside a scroll view builds every tile unconditionally,
        // unlike ListView's lazy SliverList (which was silently skipping
        // items past a certain point regardless of cacheExtent).
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppCard(
              child: Text(
                'شکل و رنگ دقیق این علائم ممکن است بین خودروهای مختلف متفاوت '
                'باشد؛ برای اطمینان کامل به دفترچه راهنمای خودروی خود مراجعه '
                'کنید. این راهنما جایگزین بازدید تعمیرکار نیست.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            for (final light in warningLights) _WarningLightTile(light: light),
          ],
        ),
      ),
    );
  }
}

class _WarningLightTile extends StatelessWidget {
  const _WarningLightTile({required this.light});

  final WarningLight light;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = theme.extension<AppSemanticColors>()!;
    final color = switch (light.severity) {
      WarningLightSeverity.critical => theme.colorScheme.error,
      WarningLightSeverity.warning => semantic.warning,
      WarningLightSeverity.info => theme.colorScheme.primary,
    };

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(light.icon, color: color),
        title: Text(light.title),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(light.meaning, style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 18, color: color),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        light.action,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
