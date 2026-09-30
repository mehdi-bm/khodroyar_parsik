import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../vehicles/cubit/active_vehicle_cubit.dart';
import '../../../vehicles/cubit/active_vehicle_state.dart';
import '../../../vehicles/cubit/vehicle_list_cubit.dart';
import '../../../vehicles/cubit/vehicle_list_state.dart';
import '../../../vehicles/data/vehicle_repository.dart';

/// Quick vehicle switcher chips — only shown when the user has 2+ vehicles.
class VehicleSwitcherRow extends StatelessWidget {
  const VehicleSwitcherRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VehicleListCubit(getIt<VehicleRepository>())..watch(),
      child: BlocBuilder<VehicleListCubit, VehicleListState>(
        builder: (context, state) {
          if (state is! VehicleListLoaded || state.vehicles.length < 2) {
            return const SizedBox.shrink();
          }

          final activeState = context.watch<ActiveVehicleCubit>().state;
          final activeId = activeState is ActiveVehicleLoaded
              ? activeState.vehicle?.id
              : null;

          return SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.vehicles.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final vehicle = state.vehicles[index];
                return ChoiceChip(
                  label: Text(vehicle.name),
                  selected: vehicle.id == activeId,
                  onSelected: (_) => context
                      .read<ActiveVehicleCubit>()
                      .selectVehicle(vehicle.id),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
