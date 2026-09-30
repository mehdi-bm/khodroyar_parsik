import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/maintenance_repository.dart';
import 'maintenance_list_state.dart';

class MaintenanceListCubit extends Cubit<MaintenanceListState> {
  MaintenanceListCubit(this._repository)
    : super(const MaintenanceListLoading());

  final MaintenanceRepository _repository;
  StreamSubscription? _subscription;

  void watch(int vehicleId) {
    _subscription?.cancel();
    _subscription = _repository
        .watchForVehicle(vehicleId)
        .listen(
          (records) => emit(MaintenanceListLoaded(records)),
          onError: (Object error) =>
              emit(const MaintenanceListError('خطا در بارگذاری سرویس‌ها')),
        );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
