// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_dao.dart';

// ignore_for_file: type=lint
mixin _$DocumentDaoMixin on DatabaseAccessor<AppDatabase> {
  $VehiclesTable get vehicles => attachedDatabase.vehicles;
  $DocumentsTable get documents => attachedDatabase.documents;
  DocumentDaoManager get managers => DocumentDaoManager(this);
}

class DocumentDaoManager {
  final _$DocumentDaoMixin _db;
  DocumentDaoManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db.attachedDatabase, _db.vehicles);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db.attachedDatabase, _db.documents);
}
