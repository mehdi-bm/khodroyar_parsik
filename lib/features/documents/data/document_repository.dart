import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/notifications/notification_scheduler.dart';

class DocumentRepository {
  DocumentRepository(this._db, [this._notificationScheduler]);

  final AppDatabase _db;

  /// Nullable so plain repository tests don't need a real notification
  /// stack — only the app's real service_locator wiring provides one.
  final NotificationScheduler? _notificationScheduler;

  Stream<List<Document>> watchForVehicle(int vehicleId) =>
      _db.documentDao.watchForVehicle(vehicleId);

  Future<Document?> getById(int id) => _db.documentDao.getById(id);

  Future<int> addDocument({
    required int vehicleId,
    required String title,
    required String type,
    DateTime? startDate,
    required DateTime expirationDate,
    String? photoPath,
    String? notes,
  }) async {
    final id = await _db.documentDao.insertDocument(
      DocumentsCompanion.insert(
        vehicleId: vehicleId,
        title: title,
        type: type,
        startDate: Value(startDate),
        expirationDate: expirationDate,
        photoPath: Value(photoPath),
        notes: Value(notes),
      ),
    );
    await _scheduleReminder(id);
    return id;
  }

  Future<void> updateDocument({
    required int id,
    required int vehicleId,
    required String title,
    required String type,
    DateTime? startDate,
    required DateTime expirationDate,
    String? photoPath,
    String? notes,
  }) async {
    await _db.documentDao.updateDocument(
      DocumentsCompanion(
        id: Value(id),
        vehicleId: Value(vehicleId),
        title: Value(title),
        type: Value(type),
        startDate: Value(startDate),
        expirationDate: Value(expirationDate),
        photoPath: Value(photoPath),
        notes: Value(notes),
      ),
    );
    await _scheduleReminder(id);
  }

  Future<void> deleteDocument(int id) async {
    await _db.documentDao.deleteDocument(id);
    await _notificationScheduler?.cancelForDocument(id);
  }

  Future<void> _scheduleReminder(int id) async {
    if (_notificationScheduler == null) return;
    final saved = await _db.documentDao.getById(id);
    if (saved != null) {
      await _notificationScheduler.scheduleForDocument(saved);
    }
  }
}
