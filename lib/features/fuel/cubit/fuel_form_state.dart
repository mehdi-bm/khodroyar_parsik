sealed class FuelFormState {
  const FuelFormState();
}

class FuelFormIdle extends FuelFormState {
  const FuelFormIdle();
}

class FuelFormSubmitting extends FuelFormState {
  const FuelFormSubmitting();
}

class FuelFormSuccess extends FuelFormState {
  const FuelFormSuccess();
}

class FuelFormFailure extends FuelFormState {
  const FuelFormFailure(this.message);
  final String message;
}
