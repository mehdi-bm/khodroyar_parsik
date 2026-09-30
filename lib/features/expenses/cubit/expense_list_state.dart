import '../../../core/database/app_database.dart';

sealed class ExpenseListState {
  const ExpenseListState();
}

class ExpenseListLoading extends ExpenseListState {
  const ExpenseListLoading();
}

class ExpenseListLoaded extends ExpenseListState {
  const ExpenseListLoaded(this.records);
  final List<ExpenseRecord> records;
}

class ExpenseListError extends ExpenseListState {
  const ExpenseListError(this.message);
  final String message;
}
