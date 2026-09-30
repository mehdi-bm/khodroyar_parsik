import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// The four states used across maintenance, documents, and reports to show
/// how urgent something is (service due, insurance expiring, ...).
enum AppStatusLevel { good, upcoming, due, overdue }

/// A reusable status indicator that always pairs an icon with text and
/// color together — per the app's accessibility rule, status must never be
/// conveyed by color alone.
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.level, required this.label});

  final AppStatusLevel level;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = theme.extension<AppSemanticColors>()!;
    final (color, icon) = switch (level) {
      AppStatusLevel.good => (semantic.success, Icons.check_circle),
      AppStatusLevel.upcoming => (semantic.warning, Icons.access_time_filled),
      AppStatusLevel.due => (semantic.warning, Icons.warning_rounded),
      AppStatusLevel.overdue => (theme.colorScheme.error, Icons.error_rounded),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
