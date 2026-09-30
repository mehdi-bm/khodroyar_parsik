import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/vehicle_repository.dart';
import 'vehicle_list_state.dart';

class VehicleListCubit extends Cubit<VehicleListState> {
  VehicleListCubit(this._repository) : super(const VehicleListLoading());

  final VehicleRepository _repository;
  StreamSubscription? _subscription;

  void watch() {
    _subscription?.cancel();
    _subscription = _repository.watchAllVehicles().listen(
      (vehicles) => emit(VehicleListLoaded(vehicles)),
      onError: (Object error) =>
          emit(const VehicleListError('خطا در بارگذاری خودروها')),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
