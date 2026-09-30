import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/expense_repository.dart';
import 'expense_form_state.dart';

class ExpenseFormCubit extends Cubit<ExpenseFormState> {
  ExpenseFormCubit(this._repository) : super(const ExpenseFormIdle());

  final ExpenseRepository _repository;

  Future<void> submit({
    int? id,
    required int vehicleId,
    required String category,
    required int amount,
    required DateTime date,
    String? description,
    String? photoPath,
  }) async {
    if (isClosed || state is ExpenseFormSubmitting) return;
    emit(const ExpenseFormSubmitting());
    try {
      if (id == null) {
        await _repository.addRecord(
          vehicleId: vehicleId,
          category: category,
          amount: amount,
          date: date,
          description: description,
          photoPath: photoPath,
        );
      } else {
        await _repository.updateRecord(
          id: id,
          vehicleId: vehicleId,
          category: category,
          amount: amount,
          date: date,
          description: description,
          photoPath: photoPath,
        );
      }
      if (!isClosed) emit(const ExpenseFormSuccess());
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('ExpenseFormCubit.submit failed: $error\n$stackTrace');
      }
      if (!isClosed) {
        emit(const ExpenseFormFailure('عملیات انجام نشد. دوباره تلاش کنید.'));
      }
    }
  }
}
