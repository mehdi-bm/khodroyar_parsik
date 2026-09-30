import '../../../core/database/app_database.dart';

sealed class MaintenanceScheduleListState {
  const MaintenanceScheduleListState();
}

class MaintenanceScheduleListLoading extends MaintenanceScheduleListState {
  const MaintenanceScheduleListLoading();
}

class MaintenanceScheduleListLoaded extends MaintenanceScheduleListState {
  const MaintenanceScheduleListLoaded(this.schedules);
  final List<MaintenanceSchedule> schedules;
}
