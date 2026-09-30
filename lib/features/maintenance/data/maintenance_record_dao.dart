import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import 'maintenance_records_table.dart';

part 'maintenance_record_dao.g.dart';

@DriftAccessor(tables: [MaintenanceRecords])
class MaintenanceRecordDao extends DatabaseAccessor<AppDatabase>
    with _$MaintenanceRecordDaoMixin {
  MaintenanceRecordDao(super.db);

  Stream<List<MaintenanceRecord>> watchForVehicle(int vehicleId) =>
      (select(maintenanceRecords)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Future<MaintenanceRecord?> getById(int id) => (select(
    maintenanceRecords,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertRecord(MaintenanceRecordsCompanion entry) =>
      into(maintenanceRecords).insert(entry);

  Future<bool> updateRecord(MaintenanceRecordsCompanion entry) =>
      update(maintenanceRecords).replace(entry);

  Future<int> deleteRecord(int id) =>
      (delete(maintenanceRecords)..where((t) => t.id.equals(id))).go();
}
