import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import 'expense_records_table.dart';

part 'expense_record_dao.g.dart';

@DriftAccessor(tables: [ExpenseRecords])
class ExpenseRecordDao extends DatabaseAccessor<AppDatabase>
    with _$ExpenseRecordDaoMixin {
  ExpenseRecordDao(super.db);

  Stream<List<ExpenseRecord>> watchForVehicle(int vehicleId) =>
      (select(expenseRecords)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Future<ExpenseRecord?> getById(int id) =>
      (select(expenseRecords)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertRecord(ExpenseRecordsCompanion entry) =>
      into(expenseRecords).insert(entry);

  Future<bool> updateRecord(ExpenseRecordsCompanion entry) =>
      update(expenseRecords).replace(entry);

  Future<int> deleteRecord(int id) =>
      (delete(expenseRecords)..where((t) => t.id.equals(id))).go();
}
