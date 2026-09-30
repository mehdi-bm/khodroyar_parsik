import '../../../core/database/app_database.dart';

sealed class FuelListState {
  const FuelListState();
}

class FuelListLoading extends FuelListState {
  const FuelListLoading();
}

class FuelListLoaded extends FuelListState {
  const FuelListLoaded(this.records);
  final List<FuelRecord> records;
}

class FuelListError extends FuelListState {
  const FuelListError(this.message);
  final String message;
}
