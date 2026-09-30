sealed class VehicleFormState {
  const VehicleFormState();
}

class VehicleFormIdle extends VehicleFormState {
  const VehicleFormIdle();
}

class VehicleFormSubmitting extends VehicleFormState {
  const VehicleFormSubmitting();
}

class VehicleFormSuccess extends VehicleFormState {
  const VehicleFormSuccess();
}

class VehicleFormFailure extends VehicleFormState {
  const VehicleFormFailure(this.message);
  final String message;
}
