import '../../../core/database/app_database.dart';

sealed class MaintenanceListState {
  const MaintenanceListState();
}

class MaintenanceListLoading extends MaintenanceListState {
  const MaintenanceListLoading();
}

class MaintenanceListLoaded extends MaintenanceListState {
  const MaintenanceListLoaded(this.records);
  final List<MaintenanceRecord> records;
}

class MaintenanceListError extends MaintenanceListState {
  const MaintenanceListError(this.message);
  final String message;
}
