import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/number_format.dart';
import '../../../../core/utils/persian_date.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/fuel_consumption_calculator.dart';

enum _CardAction { edit, delete }

class FuelRecordCard extends StatelessWidget {
  const FuelRecordCard({
    super.key,
    required this.record,
    required this.consumption,
    required this.onEdit,
    required this.onDelete,
  });

  final FuelRecord record;

  /// Pre-computed via [consumptionAt] by the list page (needs the full
  /// vehicle history) — `null` when not enough data exists yet.
  final double? consumption;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${formatNumber(record.fuelAmountLiters)} لیتر',
                      style: theme.textTheme.titleMedium,
                    ),
                    if (record.isFullTank) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(AppSpacing.xs),
                        ),
                        child: Text(
                          'باک پر',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${formatJalaliDate(record.date)}  •  ${formatNumber(record.mileage)} کیلومتر',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${formatNumber(record.totalCost)} تومان',
                  style: theme.textTheme.bodyMedium,
                ),
                if (consumption != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'مصرف تقریبی: ${formatFuelConsumption(consumption!)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          PopupMenuButton<_CardAction>(
            onSelected: (action) => switch (action) {
              _CardAction.edit => onEdit(),
              _CardAction.delete => onDelete(),
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: _CardAction.edit, child: Text('ویرایش')),
              PopupMenuItem(value: _CardAction.delete, child: Text('حذف')),
            ],
          ),
        ],
      ),
    );
  }
}
