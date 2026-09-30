// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_record_dao.dart';

// ignore_for_file: type=lint
mixin _$ExpenseRecordDaoMixin on DatabaseAccessor<AppDatabase> {
  $VehiclesTable get vehicles => attachedDatabase.vehicles;
  $ExpenseRecordsTable get expenseRecords => attachedDatabase.expenseRecords;
  ExpenseRecordDaoManager get managers => ExpenseRecordDaoManager(this);
}

class ExpenseRecordDaoManager {
  final _$ExpenseRecordDaoMixin _db;
  ExpenseRecordDaoManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db.attachedDatabase, _db.vehicles);
  $$ExpenseRecordsTableTableManager get expenseRecords =>
      $$ExpenseRecordsTableTableManager(
        _db.attachedDatabase,
        _db.expenseRecords,
      );
}
