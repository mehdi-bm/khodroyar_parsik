import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import 'vehicles_table.dart';

part 'vehicle_dao.g.dart';

@DriftAccessor(tables: [Vehicles])
class VehicleDao extends DatabaseAccessor<AppDatabase> with _$VehicleDaoMixin {
  VehicleDao(super.db);

  Stream<List<Vehicle>> watchAll() => (select(
    vehicles,
  )..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).watch();

  Stream<Vehicle?> watchById(int id) =>
      (select(vehicles)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<Vehicle?> getById(int id) =>
      (select(vehicles)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertVehicle(VehiclesCompanion entry) =>
      into(vehicles).insert(entry);

  Future<bool> updateVehicle(VehiclesCompanion entry) =>
      update(vehicles).replace(entry);

  Future<int> deleteVehicle(int id) =>
      (delete(vehicles)..where((t) => t.id.equals(id))).go();
}
