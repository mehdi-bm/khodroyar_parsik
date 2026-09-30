import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import 'documents_table.dart';

part 'document_dao.g.dart';

@DriftAccessor(tables: [Documents])
class DocumentDao extends DatabaseAccessor<AppDatabase>
    with _$DocumentDaoMixin {
  DocumentDao(super.db);

  Stream<List<Document>> watchForVehicle(int vehicleId) =>
      (select(documents)
            ..where((t) => t.vehicleId.equals(vehicleId))
            ..orderBy([(t) => OrderingTerm.asc(t.expirationDate)]))
          .watch();

  Future<Document?> getById(int id) =>
      (select(documents)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertDocument(DocumentsCompanion entry) =>
      into(documents).insert(entry);

  Future<bool> updateDocument(DocumentsCompanion entry) =>
      update(documents).replace(entry);

  Future<int> deleteDocument(int id) =>
      (delete(documents)..where((t) => t.id.equals(id))).go();
}
