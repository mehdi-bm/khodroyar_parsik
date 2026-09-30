import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/number_format.dart';
import '../../../../core/utils/persian_date.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/expense_category.dart';

enum _CardAction { edit, delete }

class ExpenseRecordCard extends StatelessWidget {
  const ExpenseRecordCard({
    super.key,
    required this.record,
    required this.onEdit,
    required this.onDelete,
  });

  final ExpenseRecord record;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final category = ExpenseCategory.fromStorageKey(record.category);

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category.label, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  formatJalaliDate(record.date),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${formatNumber(record.amount)} تومان',
                  style: theme.textTheme.bodyMedium,
                ),
                if (record.description != null &&
                    record.description!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(record.description!, style: theme.textTheme.bodySmall),
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
