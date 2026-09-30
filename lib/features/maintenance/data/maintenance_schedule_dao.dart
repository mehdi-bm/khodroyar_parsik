import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import 'maintenance_schedules_table.dart';

part 'maintenance_schedule_dao.g.dart';

@DriftAccessor(tables: [MaintenanceSchedules])
class MaintenanceScheduleDao extends DatabaseAccessor<AppDatabase>
    with _$MaintenanceScheduleDaoMixin {
  MaintenanceScheduleDao(super.db);

  Stream<List<MaintenanceSchedule>> watchForVehicle(int vehicleId) => (select(
    maintenanceSchedules,
  )..where((t) => t.vehicleId.equals(vehicleId))).watch();

  Future<MaintenanceSchedule?> getById(int id) => (select(
    maintenanceSchedules,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<MaintenanceSchedule?> getForVehicleAndCategory(
    int vehicleId,
    String category,
  ) =>
      (select(maintenanceSchedules)..where(
            (t) => t.vehicleId.equals(vehicleId) & t.category.equals(category),
          ))
          .getSingleOrNull();

  Future<int> insertSchedule(MaintenanceSchedulesCompanion entry) =>
      into(maintenanceSchedules).insert(entry);

  Future<bool> updateSchedule(MaintenanceSchedulesCompanion entry) =>
      update(maintenanceSchedules).replace(entry);

  Future<int> deleteSchedule(int id) =>
      (delete(maintenanceSchedules)..where((t) => t.id.equals(id))).go();
}
