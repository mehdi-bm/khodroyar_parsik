import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/number_format.dart';
import '../../../core/widgets/empty_state_icon.dart';
import '../../advertising/cubit/ad_banner_cubit.dart';
import '../../advertising/data/advertising_gateway.dart';
import '../../advertising/presentation/widgets/ad_banner_carousel.dart';
import '../../vehicles/cubit/active_vehicle_cubit.dart';
import '../../vehicles/cubit/active_vehicle_state.dart';
import 'widgets/fuel_summary_card.dart';
import 'widgets/monthly_cost_card.dart';
import 'widgets/recent_activities_card.dart';
import 'widgets/vehicle_status_card.dart';
import 'widgets/vehicle_switcher_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خودرویار پارسیک')),
      // The ad banner is provided at the page level (not inside
      // _Dashboard) so it stays mounted — and its 20-minute fetch cache
      // stays warm — regardless of which vehicle is active or whether one
      // exists at all.
      body: BlocProvider(
        create: (_) =>
            AdBannerCubit(getIt<AdvertisingGateway>())..loadInitial(),
        child: Column(
          children: [
            const AdBannerCarousel(),
            Expanded(
              child: BlocBuilder<ActiveVehicleCubit, ActiveVehicleState>(
                builder: (context, state) {
                  if (state is ActiveVehicleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final vehicle = (state as ActiveVehicleLoaded).vehicle;
                  if (vehicle == null) {
                    return _NoVehicleState(
                      onAdd: () => context.push(AppRoutes.vehicleNew),
                    );
                  }
                  return _Dashboard(vehicle: vehicle);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoVehicleState extends StatelessWidget {
  const _NoVehicleState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmptyStateIcon(Icons.directions_car_outlined),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'برای شروع، یک خودرو اضافه کنید',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'سرویس‌ها، سوخت و هزینه‌های خودرو را یک‌جا ثبت کنید و موعد تمدید مدارک را به خاطر بسپارید.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('افزودن خودرو'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // The other cards all live-stream from the local database and never
    // go stale, but the ad banner is fetched from the network — pull-to-
    // refresh gives the user an explicit way to force a fresh fetch
    // without waiting for the 20-minute cache to expire.
    return RefreshIndicator(
      onRefresh: () => context.read<AdBannerCubit>().refresh(force: true),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: AppSpacing.page(context),
        children: [
          const VehicleSwitcherRow(),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.directions_car_rounded,
                  size: 40,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicle.name,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '${formatNumber(vehicle.currentMileage)} کیلومتر',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'ویرایش خودرو و کیلومتر',
                  onPressed: () =>
                      context.push(AppRoutes.vehicleEdit(vehicle.id)),
                  icon: Icon(
                    Icons.edit_outlined,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('ثبت سریع', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          _QuickActionsRow(vehicle: vehicle),
          const SizedBox(height: AppSpacing.lg),

          // Every card below owns its own BlocProvider(s) reading vehicleId
          // at create-time — BlocProvider only ever calls create() once per
          // element identity, so each card is keyed by vehicle.id to force a
          // fresh element (and fresh Cubits) when the active vehicle
          // switches, instead of silently continuing to show the previous
          // vehicle's data.
          VehicleStatusCard(
            key: ValueKey('status-${vehicle.id}'),
            vehicle: vehicle,
          ),
          const SizedBox(height: AppSpacing.lg),

          LayoutBuilder(
            builder: (context, constraints) {
              final cards = [
                MonthlyCostCard(
                  key: ValueKey('cost-${vehicle.id}'),
                  vehicleId: vehicle.id,
                ),
                FuelSummaryCard(
                  key: ValueKey('fuel-${vehicle.id}'),
                  vehicleId: vehicle.id,
                ),
              ];
              if (constraints.maxWidth < 380 ||
                  MediaQuery.textScalerOf(context).scale(14) > 18) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    cards[0],
                    const SizedBox(height: AppSpacing.md),
                    cards[1],
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: cards[0]),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: cards[1]),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          RecentActivitiesCard(
            key: ValueKey('activity-${vehicle.id}'),
            vehicleId: vehicle.id,
          ),
        ],
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow({required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 500 ? 4 : 2;
        final width =
            (constraints.maxWidth - AppSpacing.sm * (columns - 1)) / columns;
        final actions = [
          (
            Icons.build_outlined,
            'ثبت سرویس',
            AppRoutes.maintenanceNew(vehicle.id),
          ),
          (
            Icons.local_gas_station_outlined,
            'ثبت سوخت',
            AppRoutes.fuelNew(vehicle.id),
          ),
          (
            Icons.payments_outlined,
            'ثبت هزینه',
            AppRoutes.expenseNew(vehicle.id),
          ),
          (
            Icons.description_outlined,
            'ثبت مدرک',
            AppRoutes.documentNew(vehicle.id),
          ),
        ];
        return Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final action in actions)
              SizedBox(
                width: width,
                child: _QuickActionButton(
                  icon: action.$1,
                  label: action.$2,
                  onTap: () => context.push(action.$3),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22),
            const SizedBox(width: AppSpacing.sm),
            Flexible(child: Text(label, textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
  }
}
