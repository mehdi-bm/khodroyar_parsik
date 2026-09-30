import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/number_format.dart';
import '../../../core/utils/persian_date.dart';
import '../../../core/widgets/empty_state_icon.dart';
import '../../documents/cubit/document_list_cubit.dart';
import '../../documents/cubit/document_list_state.dart';
import '../../documents/data/document_repository.dart';
import '../../expenses/cubit/expense_list_cubit.dart';
import '../../expenses/cubit/expense_list_state.dart';
import '../../expenses/data/expense_repository.dart';
import '../../fuel/cubit/fuel_list_cubit.dart';
import '../../fuel/cubit/fuel_list_state.dart';
import '../../fuel/data/fuel_repository.dart';
import '../../maintenance/cubit/maintenance_list_cubit.dart';
import '../../maintenance/cubit/maintenance_list_state.dart';
import '../../maintenance/data/maintenance_repository.dart';
import '../../vehicles/cubit/active_vehicle_cubit.dart';
import '../../vehicles/cubit/active_vehicle_state.dart';
import '../domain/timeline_entry.dart';

/// The complete chronological history of a vehicle — every maintenance,
/// fuel, expense, and document record ever logged, grouped by Jalali
/// month. Unlike the Home dashboard's "آخرین فعالیت‌ها" feed, nothing is
/// capped here.
class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تاریخچه کامل خودرو')),
      body: BlocBuilder<ActiveVehicleCubit, ActiveVehicleState>(
        builder: (context, state) {
          if (state is ActiveVehicleLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final vehicle = (state as ActiveVehicleLoaded).vehicle;
          if (vehicle == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  'برای مشاهده تاریخچه، ابتدا یک خودرو اضافه کنید.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          }
          return _TimelineBody(key: ValueKey(vehicle.id), vehicleId: vehicle.id);
        },
      ),
    );
  }
}

class _TimelineBody extends StatelessWidget {
  const _TimelineBody({super.key, required this.vehicleId});

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
        BlocProvider(
          create: (_) =>
              DocumentListCubit(getIt<DocumentRepository>())..watch(vehicleId),
        ),
      ],
      child: Builder(
        builder: (context) {
          final maintenanceState = context.watch<MaintenanceListCubit>().state;
          final fuelState = context.watch<FuelListCubit>().state;
          final expenseState = context.watch<ExpenseListCubit>().state;
          final documentState = context.watch<DocumentListCubit>().state;

          final entries = computeTimeline(
            maintenanceRecords: maintenanceState is MaintenanceListLoaded
                ? maintenanceState.records
                : const <MaintenanceRecord>[],
            fuelRecords: fuelState is FuelListLoaded
                ? fuelState.records
                : const <FuelRecord>[],
            expenseRecords: expenseState is ExpenseListLoaded
                ? expenseState.records
                : const <ExpenseRecord>[],
            documents: documentState is DocumentListLoaded
                ? documentState.documents
                : const <Document>[],
          );

          if (entries.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const EmptyStateIcon(Icons.history),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'هنوز هیچ فعالیتی برای این خودرو ثبت نشده است.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: AppSpacing.page(context),
            children: _buildGroupedChildren(context, entries),
          );
        },
      ),
    );
  }

  List<Widget> _buildGroupedChildren(
    BuildContext context,
    List<TimelineEntry> entries,
  ) {
    final theme = Theme.of(context);
    final children = <Widget>[];
    String? lastGroupLabel;
    for (final entry in entries) {
      final groupLabel = jalaliMonthYearLabel(entry.date);
      if (groupLabel != lastGroupLabel) {
        if (lastGroupLabel != null) {
          children.add(const SizedBox(height: AppSpacing.md));
        }
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Text(
              groupLabel,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        );
        lastGroupLabel = groupLabel;
      }
      children.add(_TimelineTile(entry: entry, vehicleId: vehicleId));
    }
    return children;
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({required this.entry, required this.vehicleId});

  final TimelineEntry entry;
  final int vehicleId;

  IconData get _icon => switch (entry.kind) {
    TimelineEntryKind.maintenance => Icons.build_outlined,
    TimelineEntryKind.fuel => Icons.local_gas_station_outlined,
    TimelineEntryKind.expense => Icons.payments_outlined,
    TimelineEntryKind.document => Icons.description_outlined,
  };

  String get _route => switch (entry.kind) {
    TimelineEntryKind.maintenance => AppRoutes.maintenanceEdit(
      vehicleId,
      entry.recordId,
    ),
    TimelineEntryKind.fuel => AppRoutes.fuelEdit(vehicleId, entry.recordId),
    TimelineEntryKind.expense => AppRoutes.expenseEdit(
      vehicleId,
      entry.recordId,
    ),
    TimelineEntryKind.document => AppRoutes.documentEdit(
      vehicleId,
      entry.recordId,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Icon(_icon, color: theme.colorScheme.onPrimaryContainer),
      ),
      title: Text(entry.title),
      subtitle: entry.subtitle.isEmpty ? null : Text(entry.subtitle),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(formatJalaliDate(entry.date), style: theme.textTheme.labelSmall),
          if (entry.amount != null)
            Text(
              '${formatNumber(entry.amount!)} تومان',
              style: theme.textTheme.bodySmall,
            ),
        ],
      ),
      onTap: () => context.push(_route),
    );
  }
}
