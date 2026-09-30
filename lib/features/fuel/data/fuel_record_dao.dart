import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import 'fuel_records_table.dart';

part 'fuel_record_dao.g.dart';

@DriftAccessor(tables: [FuelRecords])
class FuelRecordDao extends DatabaseAccessor<AppDatabase>
    with _$FuelRecordDaoMixin {
  FuelRecordDao(super.db);

  Stream<List<FuelRecord>> watchForVehicle(int vehicleId) =>
      (select(fuelRecords)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Future<List<FuelRecord>> getAllForVehicle(int vehicleId) =>
      (select(fuelRecords)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  Future<FuelRecord?> getById(int id) =>
      (select(fuelRecords)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertRecord(FuelRecordsCompanion entry) =>
      into(fuelRecords).insert(entry);

  Future<bool> updateRecord(FuelRecordsCompanion entry) =>
      update(fuelRecords).replace(entry);

  Future<int> deleteRecord(int id) =>
      (delete(fuelRecords)..where((t) => t.id.equals(id))).go();
}
