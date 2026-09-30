import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

class ExpenseRepository {
  ExpenseRepository(this._db);

  final AppDatabase _db;

  Stream<List<ExpenseRecord>> watchForVehicle(int vehicleId) =>
      _db.expenseRecordDao.watchForVehicle(vehicleId);

  Future<ExpenseRecord?> getById(int id) => _db.expenseRecordDao.getById(id);

  Future<int> addRecord({
    required int vehicleId,
    required String category,
    required int amount,
    required DateTime date,
    String? description,
    String? photoPath,
  }) {
    return _db.expenseRecordDao.insertRecord(
      ExpenseRecordsCompanion.insert(
        vehicleId: vehicleId,
        category: category,
        amount: amount,
        date: date,
        description: Value(description),
        photoPath: Value(photoPath),
      ),
    );
  }

  Future<void> updateRecord({
    required int id,
    required int vehicleId,
    required String category,
    required int amount,
    required DateTime date,
    String? description,
    String? photoPath,
  }) {
    return _db.expenseRecordDao.updateRecord(
      ExpenseRecordsCompanion(
        id: Value(id),
        vehicleId: Value(vehicleId),
        category: Value(category),
        amount: Value(amount),
        date: Value(date),
        description: Value(description),
        photoPath: Value(photoPath),
      ),
    );
  }

  Future<void> deleteRecord(int id) => _db.expenseRecordDao.deleteRecord(id);
}
