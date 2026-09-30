import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/vehicle_mileage.dart';

class MaintenanceRepository {
  MaintenanceRepository(this._db);

  final AppDatabase _db;

  Stream<List<MaintenanceRecord>> watchForVehicle(int vehicleId) =>
      _db.maintenanceRecordDao.watchForVehicle(vehicleId);

  Future<MaintenanceRecord?> getById(int id) =>
      _db.maintenanceRecordDao.getById(id);

  Future<int> addRecord({
    required int vehicleId,
    required String title,
    required String category,
    required DateTime date,
    required int mileage,
    int cost = 0,
    String? description,
    String? photoPath,
    int? nextServiceMileage,
    DateTime? nextServiceDate,
  }) {
    return _db.transaction(() async {
      final result = await _db.maintenanceRecordDao.insertRecord(
        MaintenanceRecordsCompanion.insert(
          vehicleId: vehicleId,
          title: title,
          category: category,
          date: date,
          mileage: mileage,
          cost: Value(cost),
          description: Value(description),
          photoPath: Value(photoPath),
          nextServiceMileage: Value(nextServiceMileage),
          nextServiceDate: Value(nextServiceDate),
        ),
      );
      await _db.advanceMileage(vehicleId, mileage);
      return result;
    });
  }

  Future<void> updateRecord({
    required int id,
    required int vehicleId,
    required String title,
    required String category,
    required DateTime date,
    required int mileage,
    int cost = 0,
    String? description,
    String? photoPath,
    int? nextServiceMileage,
    DateTime? nextServiceDate,
  }) {
    return _db.transaction(() async {
      await _db.maintenanceRecordDao.updateRecord(
        MaintenanceRecordsCompanion(
          id: Value(id),
          vehicleId: Value(vehicleId),
          title: Value(title),
          category: Value(category),
          date: Value(date),
          mileage: Value(mileage),
          cost: Value(cost),
          description: Value(description),
          photoPath: Value(photoPath),
          nextServiceMileage: Value(nextServiceMileage),
          nextServiceDate: Value(nextServiceDate),
        ),
      );
      await _db.advanceMileage(vehicleId, mileage);
    });
  }

  Future<void> deleteRecord(int id) =>
      _db.maintenanceRecordDao.deleteRecord(id);
}
