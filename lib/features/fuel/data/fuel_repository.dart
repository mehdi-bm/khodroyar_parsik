import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/vehicle_mileage.dart';

class FuelRepository {
  FuelRepository(this._db);

  final AppDatabase _db;

  Stream<List<FuelRecord>> watchForVehicle(int vehicleId) =>
      _db.fuelRecordDao.watchForVehicle(vehicleId);

  Future<List<FuelRecord>> getAllForVehicle(int vehicleId) =>
      _db.fuelRecordDao.getAllForVehicle(vehicleId);

  Future<FuelRecord?> getById(int id) => _db.fuelRecordDao.getById(id);

  Future<int> addRecord({
    required int vehicleId,
    required DateTime date,
    required int mileage,
    required double fuelAmountLiters,
    required int totalCost,
    required bool isFullTank,
    String? notes,
  }) {
    return _db.transaction(() async {
      final result = await _db.fuelRecordDao.insertRecord(
        FuelRecordsCompanion.insert(
          vehicleId: vehicleId,
          date: date,
          mileage: mileage,
          fuelAmountLiters: fuelAmountLiters,
          totalCost: totalCost,
          pricePerLiter: Value(_pricePerLiter(totalCost, fuelAmountLiters)),
          isFullTank: Value(isFullTank),
          notes: Value(notes),
        ),
      );
      await _db.advanceMileage(vehicleId, mileage);
      return result;
    });
  }

  Future<void> updateRecord({
    required int id,
    required int vehicleId,
    required DateTime date,
    required int mileage,
    required double fuelAmountLiters,
    required int totalCost,
    required bool isFullTank,
    String? notes,
  }) {
    return _db.transaction(() async {
      await _db.fuelRecordDao.updateRecord(
        FuelRecordsCompanion(
          id: Value(id),
          vehicleId: Value(vehicleId),
          date: Value(date),
          mileage: Value(mileage),
          fuelAmountLiters: Value(fuelAmountLiters),
          totalCost: Value(totalCost),
          pricePerLiter: Value(_pricePerLiter(totalCost, fuelAmountLiters)),
          isFullTank: Value(isFullTank),
          notes: Value(notes),
        ),
      );
      await _db.advanceMileage(vehicleId, mileage);
    });
  }

  Future<void> deleteRecord(int id) => _db.fuelRecordDao.deleteRecord(id);

  double? _pricePerLiter(int totalCost, double fuelAmountLiters) =>
      fuelAmountLiters > 0 ? totalCost / fuelAmountLiters : null;
}
