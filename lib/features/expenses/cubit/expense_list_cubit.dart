import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/expense_repository.dart';
import 'expense_list_state.dart';

class ExpenseListCubit extends Cubit<ExpenseListState> {
  ExpenseListCubit(this._repository) : super(const ExpenseListLoading());

  final ExpenseRepository _repository;
  StreamSubscription? _subscription;

  void watch(int vehicleId) {
    _subscription?.cancel();
    _subscription = _repository
        .watchForVehicle(vehicleId)
        .listen(
          (records) => emit(ExpenseListLoaded(records)),
          onError: (Object error) =>
              emit(const ExpenseListError('خطا در بارگذاری هزینه‌ها')),
        );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
