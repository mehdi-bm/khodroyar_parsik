import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/empty_state_icon.dart';
import '../cubit/active_vehicle_cubit.dart';
import '../cubit/active_vehicle_state.dart';
import '../cubit/vehicle_list_cubit.dart';
import '../cubit/vehicle_list_state.dart';
import '../data/vehicle_repository.dart';
import 'widgets/vehicle_card.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VehicleListCubit(getIt<VehicleRepository>())..watch(),
      child: Scaffold(
        appBar: AppBar(title: const Text('خودرو')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(AppRoutes.vehicleNew),
          icon: const Icon(Icons.add),
          label: const Text('افزودن خودرو'),
        ),
        body: BlocBuilder<VehicleListCubit, VehicleListState>(
          builder: (context, state) {
            return switch (state) {
              VehicleListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              VehicleListError(:final message) => Center(child: Text(message)),
              VehicleListLoaded(vehicles: final vehicles)
                  when vehicles.isEmpty =>
                _EmptyState(onAdd: () => context.push(AppRoutes.vehicleNew)),
              VehicleListLoaded(:final vehicles) => _VehicleListView(
                vehicles: vehicles,
              ),
            };
          },
        ),
      ),
    );
  }
}

class _VehicleListView extends StatelessWidget {
  const _VehicleListView({required this.vehicles});

  final List<Vehicle> vehicles;

  @override
  Widget build(BuildContext context) {
    final activeState = context.watch<ActiveVehicleCubit>().state;
    final activeId = activeState is ActiveVehicleLoaded
        ? activeState.vehicle?.id
        : null;

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        96,
      ),
      itemCount: vehicles.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final vehicle = vehicles[index];
        return VehicleCard(
          vehicle: vehicle,
          isActive: vehicle.id == activeId,
          onTap: () =>
              context.read<ActiveVehicleCubit>().selectVehicle(vehicle.id),
          onEdit: () => context.push(AppRoutes.vehicleEdit(vehicle.id)),
          onDelete: () => _confirmAndDelete(context, vehicle),
        );
      },
    );
  }

  Future<void> _confirmAndDelete(BuildContext context, Vehicle vehicle) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف خودرو'),
        content: Text(
          'آیا از حذف «${vehicle.name}» مطمئن هستید؟ تمام سرویس‌ها، سوخت‌گیری‌ها، هزینه‌ها و مدارک ثبت‌شده برای این خودرو نیز حذف خواهند شد.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('انصراف'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await getIt<VehicleRepository>().deleteVehicle(vehicle.id);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('عملیات انجام نشد. دوباره تلاش کنید.')),
        );
      }
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmptyStateIcon(Icons.directions_car_outlined),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'هنوز خودرویی اضافه نکرده‌اید.',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
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
