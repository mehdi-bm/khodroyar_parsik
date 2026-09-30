import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/number_format.dart';
import '../../../../core/utils/persian_date.dart';
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
import '../../domain/recent_activity.dart';

/// The dashboard's "آخرین فعالیت‌ها" card — the most recent maintenance,
/// fuel, and expense records for the vehicle, merged into one feed.
class RecentActivitiesCard extends StatelessWidget {
  const RecentActivitiesCard({super.key, required this.vehicleId});

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

          final activities = computeRecentActivities(
            maintenanceRecords: maintenanceState is MaintenanceListLoaded
                ? maintenanceState.records
                : const <MaintenanceRecord>[],
            fuelRecords: fuelState is FuelListLoaded
                ? fuelState.records
                : const <FuelRecord>[],
            expenseRecords: expenseState is ExpenseListLoaded
                ? expenseState.records
                : const <ExpenseRecord>[],
          );

          return AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('آخرین فعالیت‌ها', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                if (activities.isEmpty)
                  Text(
                    'هنوز فعالیتی ثبت نشده است.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  )
                else
                  for (final activity in activities)
                    _ActivityRow(vehicleId: vehicleId, activity: activity),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.vehicleId, required this.activity});

  final int vehicleId;
  final RecentActivity activity;

  IconData get _icon => switch (activity.kind) {
    ActivityKind.maintenance => Icons.build_outlined,
    ActivityKind.fuel => Icons.local_gas_station_outlined,
    ActivityKind.expense => Icons.payments_outlined,
  };

  String get _route => switch (activity.kind) {
    ActivityKind.maintenance => AppRoutes.maintenanceEdit(
      vehicleId,
      activity.recordId,
    ),
    ActivityKind.fuel => AppRoutes.fuelEdit(vehicleId, activity.recordId),
    ActivityKind.expense => AppRoutes.expenseEdit(vehicleId, activity.recordId),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md),
      onTap: () => context.push(_route),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Icon(_icon, color: theme.colorScheme.primary, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(activity.title, style: theme.textTheme.bodyMedium),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              formatJalaliDate(activity.date),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              '${formatNumber(activity.amount)} تومان',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
