import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../data/location_provider.dart';
import '../data/parking_repository.dart';
import '../domain/location_result.dart';
import 'parking_state.dart';

class ParkingCubit extends Cubit<ParkingState> {
  ParkingCubit(this._repository, this._locationProvider)
    : super(const ParkingState());

  final ParkingRepository _repository;
  final LocationProvider _locationProvider;
  StreamSubscription<ParkingSpot?>? _subscription;
  int? _vehicleId;

  void watch(int vehicleId) {
    _vehicleId = vehicleId;
    _subscription?.cancel();
    _subscription = _repository.watchForVehicle(vehicleId).listen(
      (spot) => emit(state.copyWith(spot: spot, loading: false)),
      onError: (Object _) => emit(
        state.copyWith(
          loading: false,
          errorMessage: 'خطا در بارگذاری محل پارک',
        ),
      ),
    );
  }

  /// Always saves whatever [note]/[photoPath] were given — a failed GPS fix
  /// only prevents the coordinates from being attached, it never blocks
  /// saving the rest (a manual note like "نزدیک درب شرقی پارکینگ" is still
  /// useful on its own).
  Future<void> save({String? note, String? photoPath}) async {
    final vehicleId = _vehicleId;
    if (vehicleId == null) return;

    emit(state.copyWith(saving: true, errorMessage: null));
    final result = await _locationProvider.getCurrentLocation();

    double? latitude;
    double? longitude;
    String? error;
    if (result is LocationSuccess) {
      latitude = result.latitude;
      longitude = result.longitude;
    } else if (result is LocationFailure) {
      error = result.message;
    }

    await _repository.saveSpot(
      vehicleId: vehicleId,
      latitude: latitude,
      longitude: longitude,
      note: note,
      photoPath: photoPath,
    );
    emit(state.copyWith(saving: false, errorMessage: error));
  }

  Future<void> clear() async {
    final vehicleId = _vehicleId;
    if (vehicleId == null) return;
    await _repository.clearSpot(vehicleId);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
