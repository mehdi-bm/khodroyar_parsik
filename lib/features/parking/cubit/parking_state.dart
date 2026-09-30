import '../../../core/database/app_database.dart';

const Object _unset = Object();

class ParkingState {
  const ParkingState({
    this.spot,
    this.loading = true,
    this.saving = false,
    this.errorMessage,
  });

  final ParkingSpot? spot;
  final bool loading;
  final bool saving;
  final String? errorMessage;

  ParkingState copyWith({
    Object? spot = _unset,
    bool? loading,
    bool? saving,
    Object? errorMessage = _unset,
  }) {
    return ParkingState(
      spot: spot == _unset ? this.spot : spot as ParkingSpot?,
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      errorMessage: errorMessage == _unset
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
