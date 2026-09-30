import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';

/// Read-only summary of [vehicle]'s consumable-part specs ("دفترچه مشخصات
/// قطعات مصرفی"), with a shortcut into the edit form since this card has no
/// editing of its own. Only rows with a non-empty value are shown.
class VehicleSpecsCard extends StatelessWidget {
  const VehicleSpecsCard({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rows = <(String, String?)>[
      ('نوع روغن موتور', vehicle.oilType),
      ('مدل فیلتر روغن', vehicle.oilFilterModel),
      ('مدل فیلتر هوا', vehicle.airFilterModel),
      ('مدل فیلتر کابین', vehicle.cabinFilterModel),
      ('سایز لاستیک', vehicle.tireSize),
      ('مدل باتری', vehicle.batteryModel),
      ('مدل شمع', vehicle.sparkPlugModel),
    ].where((row) => (row.$2 ?? '').trim().isNotEmpty).toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'مشخصات قطعات مصرفی',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              TextButton(
                onPressed: () =>
                    context.push(AppRoutes.vehicleEdit(vehicle.id)),
                child: const Text('ویرایش'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (rows.isEmpty)
            Text(
              'هنوز مشخصات قطعه‌ای برای این خودرو ثبت نشده است.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          else
            for (final row in rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        row.$1,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        row.$2!,
                        textAlign: TextAlign.end,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
