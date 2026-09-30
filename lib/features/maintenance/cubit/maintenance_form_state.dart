sealed class MaintenanceFormState {
  const MaintenanceFormState();
}

class MaintenanceFormIdle extends MaintenanceFormState {
  const MaintenanceFormIdle();
}

class MaintenanceFormSubmitting extends MaintenanceFormState {
  const MaintenanceFormSubmitting();
}

class MaintenanceFormSuccess extends MaintenanceFormState {
  const MaintenanceFormSuccess();
}

class MaintenanceFormFailure extends MaintenanceFormState {
  const MaintenanceFormFailure(this.message);
  final String message;
}
