import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/vehicle_repository.dart';
import 'active_vehicle_state.dart';

/// App-wide: which vehicle the user is currently working with. Provided at
/// the root of the widget tree so the dashboard, maintenance, fuel, etc.
/// features can all read it in later phases.
class ActiveVehicleCubit extends Cubit<ActiveVehicleState> {
  ActiveVehicleCubit(this._repository) : super(const ActiveVehicleLoading());

  final VehicleRepository _repository;
  StreamSubscription? _subscription;

  void watch() {
    _subscription?.cancel();
    _subscription = _repository.watchActiveVehicle().listen(
      (vehicle) => emit(ActiveVehicleLoaded(vehicle)),
    );
  }

  Future<void> selectVehicle(int id) => _repository.setActiveVehicle(id);

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
