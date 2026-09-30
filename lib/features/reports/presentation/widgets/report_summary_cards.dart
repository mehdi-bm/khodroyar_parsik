import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/number_format.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/report_calculator.dart';

class ReportSummaryCards extends StatelessWidget {
  const ReportSummaryCards({super.key, required this.summary});

  final ReportSummary summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SummaryCard(
          title: 'هزینه کل',
          value: '${formatNumber(summary.totalCost)} تومان',
          highlighted: true,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                title: 'هزینه سوخت',
                value: '${formatNumber(summary.fuelCost)} تومان',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _SummaryCard(
                title: 'هزینه تعمیرات',
                value: '${formatNumber(summary.maintenanceCost)} تومان',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                title: 'سایر هزینه‌ها',
                value: '${formatNumber(summary.otherExpenseCost)} تومان',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _SummaryCard(
                title: 'تعداد سرویس‌ها',
                value: formatNumber(summary.maintenanceCount),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    this.highlighted = false,
  });

  final String title;
  final String value;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style:
                (highlighted
                        ? theme.textTheme.headlineMedium
                        : theme.textTheme.titleLarge)
                    ?.copyWith(
                      color: highlighted ? theme.colorScheme.primary : null,
                    ),
          ),
        ],
      ),
    );
  }
}
