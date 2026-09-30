import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../fuel/cubit/fuel_list_cubit.dart';
import '../../../fuel/cubit/fuel_list_state.dart';
import '../../../fuel/data/fuel_repository.dart';
import '../../../fuel/domain/fuel_consumption_calculator.dart';

/// The dashboard's "مصرف سوخت اخیر" card — shows the most recent computable
/// approximate consumption, or the spec's required insufficient-data
/// message when there isn't enough history yet.
class FuelSummaryCard extends StatelessWidget {
  const FuelSummaryCard({super.key, required this.vehicleId});

  final int vehicleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FuelListCubit(getIt<FuelRepository>())..watch(vehicleId),
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          final state = context.watch<FuelListCubit>().state;
          final records = state is FuelListLoaded
              ? state.records
              : const <FuelRecord>[];
          final consumption = latestFuelConsumption(records);

          return AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('مصرف سوخت', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  consumption == null
                      ? 'با ثبت دو سوخت‌گیری با باک پُر، میانگین مصرف نمایش داده می‌شود.'
                      : formatFuelConsumption(consumption),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
