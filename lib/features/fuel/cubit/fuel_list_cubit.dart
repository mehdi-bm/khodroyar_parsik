import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/fuel_repository.dart';
import 'fuel_list_state.dart';

class FuelListCubit extends Cubit<FuelListState> {
  FuelListCubit(this._repository) : super(const FuelListLoading());

  final FuelRepository _repository;
  StreamSubscription? _subscription;

  void watch(int vehicleId) {
    _subscription?.cancel();
    _subscription = _repository
        .watchForVehicle(vehicleId)
        .listen(
          (records) => emit(FuelListLoaded(records)),
          onError: (Object error) =>
              emit(const FuelListError('خطا در بارگذاری سوخت‌گیری‌ها')),
        );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
