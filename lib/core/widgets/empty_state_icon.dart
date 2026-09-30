import 'package:flutter/material.dart';

/// A soft, tinted circular badge around an outline icon — used at the top
/// of every empty-list state (vehicles, maintenance, fuel, expenses,
/// documents, dashboard). A bare gray icon reads as unfinished/placeholder;
/// this is the one shared spot to make every empty state look intentional.
class EmptyStateIcon extends StatelessWidget {
  const EmptyStateIcon(this.icon, {super.key, this.size = 64});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: size * 1.7,
      height: size * 1.7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.primaryContainer.withValues(alpha: 0.5),
      ),
      child: Icon(icon, size: size * 0.55, color: colorScheme.primary),
    );
  }
}
