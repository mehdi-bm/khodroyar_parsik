import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/persian_date.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/document_status_calculator.dart';
import '../../domain/document_type.dart';

enum _CardAction { edit, delete }

class DocumentRecordCard extends StatelessWidget {
  const DocumentRecordCard({
    super.key,
    required this.document,
    required this.onEdit,
    required this.onDelete,
  });

  final Document document;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final type = DocumentType.fromStorageKey(document.type);
    final today = DateTime.now();
    final level = computeDocumentStatus(
      expirationDate: document.expirationDate,
      today: today,
    );
    final remaining = describeDocumentRemaining(
      expirationDate: document.expirationDate,
      today: today,
    );

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(document.title, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(type.label, style: theme.textTheme.bodySmall),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'انقضا: ${formatJalaliDate(document.expirationDate)}',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                StatusBadge(level: level, label: remaining),
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
