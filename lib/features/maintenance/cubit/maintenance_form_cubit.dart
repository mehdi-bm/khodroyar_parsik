import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/maintenance_repository.dart';
import '../data/maintenance_schedule_repository.dart';
import 'maintenance_form_state.dart';

class MaintenanceFormCubit extends Cubit<MaintenanceFormState> {
  MaintenanceFormCubit(this._repository, this._scheduleRepository)
    : super(const MaintenanceFormIdle());

  final MaintenanceRepository _repository;
  final MaintenanceScheduleRepository _scheduleRepository;

  Future<void> submit({
    int? id,
    required int vehicleId,
    required String title,
    required String category,
    required DateTime date,
    required int mileage,
    required int cost,
    String? description,
    String? photoPath,
    int? nextServiceMileage,
    DateTime? nextServiceDate,
  }) async {
    if (isClosed || state is MaintenanceFormSubmitting) return;
    emit(const MaintenanceFormSubmitting());
    try {
      if (id == null) {
        await _repository.addRecord(
          vehicleId: vehicleId,
          title: title,
          category: category,
          date: date,
          mileage: mileage,
          cost: cost,
          description: description,
          photoPath: photoPath,
          nextServiceMileage: nextServiceMileage,
          nextServiceDate: nextServiceDate,
        );
      } else {
        await _repository.updateRecord(
          id: id,
          vehicleId: vehicleId,
          title: title,
          category: category,
          date: date,
          mileage: mileage,
          cost: cost,
          description: description,
          photoPath: photoPath,
          nextServiceMileage: nextServiceMileage,
          nextServiceDate: nextServiceDate,
        );
      }
      // Logging a "next service" hint turns this category into an ongoing
      // recurring schedule (see MaintenanceScheduleRepository.upsertFromRecord).
      await _scheduleRepository.upsertFromRecord(
        vehicleId: vehicleId,
        category: category,
        title: title,
        serviceMileage: mileage,
        serviceDate: date,
        nextServiceMileage: nextServiceMileage,
        nextServiceDate: nextServiceDate,
      );
      if (!isClosed) emit(const MaintenanceFormSuccess());
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('MaintenanceFormCubit.submit failed: $error\n$stackTrace');
      }
      if (!isClosed) {
        emit(
          const MaintenanceFormFailure('عملیات انجام نشد. دوباره تلاش کنید.'),
        );
      }
    }
  }
}
