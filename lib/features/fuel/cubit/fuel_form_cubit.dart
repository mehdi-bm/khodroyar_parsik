import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/fuel_repository.dart';
import 'fuel_form_state.dart';

class FuelFormCubit extends Cubit<FuelFormState> {
  FuelFormCubit(this._repository) : super(const FuelFormIdle());

  final FuelRepository _repository;

  Future<void> submit({
    int? id,
    required int vehicleId,
    required DateTime date,
    required int mileage,
    required double fuelAmountLiters,
    required int totalCost,
    required bool isFullTank,
    String? notes,
  }) async {
    if (isClosed || state is FuelFormSubmitting) return;
    emit(const FuelFormSubmitting());
    try {
      if (id == null) {
        await _repository.addRecord(
          vehicleId: vehicleId,
          date: date,
          mileage: mileage,
          fuelAmountLiters: fuelAmountLiters,
          totalCost: totalCost,
          isFullTank: isFullTank,
          notes: notes,
        );
      } else {
        await _repository.updateRecord(
          id: id,
          vehicleId: vehicleId,
          date: date,
          mileage: mileage,
          fuelAmountLiters: fuelAmountLiters,
          totalCost: totalCost,
          isFullTank: isFullTank,
          notes: notes,
        );
      }
      if (!isClosed) emit(const FuelFormSuccess());
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('FuelFormCubit.submit failed: $error\n$stackTrace');
      }
      if (!isClosed) {
        emit(const FuelFormFailure('عملیات انجام نشد. دوباره تلاش کنید.'));
      }
    }
  }
}
