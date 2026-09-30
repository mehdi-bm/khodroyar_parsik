import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/number_format.dart';
import '../../../../core/utils/persian_digits.dart';
import '../../../../core/widgets/app_card.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.isActive,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final Vehicle vehicle;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitle = [
      vehicle.brand,
      vehicle.model,
      vehicle.modelYear == null
          ? null
          : toPersianDigits('${vehicle.modelYear}'),
    ].where((part) => part != null && part.isNotEmpty).join(' • ');

    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          _Thumbnail(photoPath: vehicle.photoPath),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        vehicle.name,
                        style: theme.textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isActive)
                      Icon(
                        Icons.check_circle,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                  ],
                ),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: theme.textTheme.bodySmall),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${formatNumber(vehicle.currentMileage)} کیلومتر',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          PopupMenuButton<_VehicleCardAction>(
            onSelected: (action) => switch (action) {
              _VehicleCardAction.edit => onEdit(),
              _VehicleCardAction.delete => onDelete(),
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: _VehicleCardAction.edit,
                child: Text('ویرایش'),
              ),
              PopupMenuItem(
                value: _VehicleCardAction.delete,
                child: Text('حذف'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _VehicleCardAction { edit, delete }

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.photoPath});

  final String? photoPath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      child: SizedBox(
        width: 56,
        height: 56,
        child: photoPath == null
            ? ColoredBox(
                color: theme.colorScheme.primaryContainer,
                child: Icon(
                  Icons.directions_car,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              )
            : Image.file(
                File(photoPath!),
                fit: BoxFit.cover,
                // Decoding at the thumbnail's own pixel size (rather than
                // the picked photo's full resolution) avoids holding a
                // multi-megapixel bitmap in memory just to show a 56dp
                // thumbnail — cheap for one card, adds up across a long
                // vehicle list.
                cacheWidth: 168,
                cacheHeight: 168,
              ),
      ),
    );
  }
}
