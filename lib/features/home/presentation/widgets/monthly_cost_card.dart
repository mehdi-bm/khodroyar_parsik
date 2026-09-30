import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/number_format.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../expenses/cubit/expense_list_cubit.dart';
import '../../../expenses/cubit/expense_list_state.dart';
import '../../../expenses/data/expense_repository.dart';
import '../../../fuel/cubit/fuel_list_cubit.dart';
import '../../../fuel/cubit/fuel_list_state.dart';
import '../../../fuel/data/fuel_repository.dart';
import '../../../maintenance/cubit/maintenance_list_cubit.dart';
import '../../../maintenance/cubit/maintenance_list_state.dart';
import '../../../maintenance/data/maintenance_repository.dart';
import '../../domain/monthly_cost_calculator.dart';

/// The dashboard's "هزینه این ماه" card — sums maintenance + fuel +
/// standalone expense costs for the current calendar month.
class MonthlyCostCard extends StatelessWidget {
  const MonthlyCostCard({super.key, required this.vehicleId});

  final int vehicleId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              MaintenanceListCubit(getIt<MaintenanceRepository>())
                ..watch(vehicleId),
        ),
        BlocProvider(
          create: (_) =>
              FuelListCubit(getIt<FuelRepository>())..watch(vehicleId),
        ),
        BlocProvider(
          create: (_) =>
              ExpenseListCubit(getIt<ExpenseRepository>())..watch(vehicleId),
        ),
      ],
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          final maintenanceState = context.watch<MaintenanceListCubit>().state;
          final fuelState = context.watch<FuelListCubit>().state;
          final expenseState = context.watch<ExpenseListCubit>().state;

          final total = computeMonthlyCost(
            maintenanceRecords: maintenanceState is MaintenanceListLoaded
                ? maintenanceState.records
                : const <MaintenanceRecord>[],
            fuelRecords: fuelState is FuelListLoaded
                ? fuelState.records
                : const <FuelRecord>[],
            expenseRecords: expenseState is ExpenseListLoaded
                ? expenseState.records
                : const <ExpenseRecord>[],
            month: DateTime.now(),
          );

          return AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('هزینه این ماه', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '${formatNumber(total)} تومان',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.primary,
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
