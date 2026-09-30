import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/number_format.dart';
import '../../../../core/utils/persian_date.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/maintenance_category.dart';

enum _CardAction { edit, delete }

class MaintenanceRecordCard extends StatelessWidget {
  const MaintenanceRecordCard({
    super.key,
    required this.record,
    required this.onEdit,
    required this.onDelete,
  });

  final MaintenanceRecord record;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final category = MaintenanceCategory.fromStorageKey(record.category);
    final nextServiceParts = [
      if (record.nextServiceMileage != null)
        '${formatNumber(record.nextServiceMileage!)} کیلومتر',
      if (record.nextServiceDate != null)
        formatJalaliDate(record.nextServiceDate!),
    ];

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.title, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(category.label, style: theme.textTheme.bodySmall),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${formatJalaliDate(record.date)}  •  ${formatNumber(record.mileage)} کیلومتر',
                  style: theme.textTheme.bodyMedium,
                ),
                if (record.cost > 0) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${formatNumber(record.cost)} تومان',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
                if (nextServiceParts.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'سرویس بعدی: ${nextServiceParts.join(' یا ')}',
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
