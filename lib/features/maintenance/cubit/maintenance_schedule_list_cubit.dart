import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/maintenance_schedule_repository.dart';
import 'maintenance_schedule_list_state.dart';

class MaintenanceScheduleListCubit extends Cubit<MaintenanceScheduleListState> {
  MaintenanceScheduleListCubit(this._repository)
    : super(const MaintenanceScheduleListLoading());

  final MaintenanceScheduleRepository _repository;
  StreamSubscription? _subscription;

  void watch(int vehicleId) {
    _subscription?.cancel();
    _subscription = _repository
        .watchForVehicle(vehicleId)
        .listen((schedules) => emit(MaintenanceScheduleListLoaded(schedules)));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
