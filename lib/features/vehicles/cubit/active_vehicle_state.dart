import '../../../core/database/app_database.dart';

sealed class ActiveVehicleState {
  const ActiveVehicleState();
}

class ActiveVehicleLoading extends ActiveVehicleState {
  const ActiveVehicleLoading();
}

class ActiveVehicleLoaded extends ActiveVehicleState {
  const ActiveVehicleLoaded(this.vehicle);

  /// `null` when the user has no vehicles yet.
  final Vehicle? vehicle;
}
