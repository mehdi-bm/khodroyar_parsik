import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Where each vehicle was last parked. Only one spot exists per vehicle at
/// a time — [saveSpot] always replaces whatever was there before.
class ParkingRepository {
  ParkingRepository(this._db);

  final AppDatabase _db;

  Stream<ParkingSpot?> watchForVehicle(int vehicleId) =>
      _db.parkingSpotDao.watchForVehicle(vehicleId);

  Future<void> saveSpot({
    required int vehicleId,
    double? latitude,
    double? longitude,
    String? note,
    String? photoPath,
  }) {
    return _db.transaction(() async {
      await _db.parkingSpotDao.deleteForVehicle(vehicleId);
      await _db.parkingSpotDao.insertSpot(
        ParkingSpotsCompanion.insert(
          vehicleId: vehicleId,
          latitude: Value(latitude),
          longitude: Value(longitude),
          note: Value(note),
          photoPath: Value(photoPath),
        ),
      );
    });
  }

  Future<void> clearSpot(int vehicleId) =>
      _db.parkingSpotDao.deleteForVehicle(vehicleId);
}
