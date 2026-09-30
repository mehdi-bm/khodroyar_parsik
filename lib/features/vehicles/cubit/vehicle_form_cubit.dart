import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/vehicle_repository.dart';
import 'vehicle_form_state.dart';

class VehicleFormCubit extends Cubit<VehicleFormState> {
  VehicleFormCubit(this._repository) : super(const VehicleFormIdle());

  final VehicleRepository _repository;

  Future<void> submit({
    int? id,
    required String name,
    String? brand,
    String? model,
    int? modelYear,
    String? color,
    String? licensePlate,
    required int currentMileage,
    String? photoPath,
    String? notes,
    String? oilType,
    String? oilFilterModel,
    String? airFilterModel,
    String? cabinFilterModel,
    String? tireSize,
    String? batteryModel,
    String? sparkPlugModel,
  }) async {
    if (isClosed || state is VehicleFormSubmitting) return;
    emit(const VehicleFormSubmitting());
    try {
      if (id == null) {
        await _repository.addVehicle(
          name: name,
          brand: brand,
          model: model,
          modelYear: modelYear,
          color: color,
          licensePlate: licensePlate,
          currentMileage: currentMileage,
          photoPath: photoPath,
          notes: notes,
          oilType: oilType,
          oilFilterModel: oilFilterModel,
          airFilterModel: airFilterModel,
          cabinFilterModel: cabinFilterModel,
          tireSize: tireSize,
          batteryModel: batteryModel,
          sparkPlugModel: sparkPlugModel,
        );
      } else {
        await _repository.updateVehicle(
          id: id,
          name: name,
          brand: brand,
          model: model,
          modelYear: modelYear,
          color: color,
          licensePlate: licensePlate,
          currentMileage: currentMileage,
          photoPath: photoPath,
          notes: notes,
          oilType: oilType,
          oilFilterModel: oilFilterModel,
          airFilterModel: airFilterModel,
          cabinFilterModel: cabinFilterModel,
          tireSize: tireSize,
          batteryModel: batteryModel,
          sparkPlugModel: sparkPlugModel,
        );
      }
      if (!isClosed) emit(const VehicleFormSuccess());
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('VehicleFormCubit.submit failed: $error\n$stackTrace');
      }
      if (!isClosed) {
        emit(const VehicleFormFailure('عملیات انجام نشد. دوباره تلاش کنید.'));
      }
    }
  }
}
