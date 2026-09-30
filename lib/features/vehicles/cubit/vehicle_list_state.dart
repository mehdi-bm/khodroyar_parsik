import '../../../core/database/app_database.dart';

sealed class VehicleListState {
  const VehicleListState();
}

class VehicleListLoading extends VehicleListState {
  const VehicleListLoading();
}

class VehicleListLoaded extends VehicleListState {
  const VehicleListLoaded(this.vehicles);
  final List<Vehicle> vehicles;
}

class VehicleListError extends VehicleListState {
  const VehicleListError(this.message);
  final String message;
}
