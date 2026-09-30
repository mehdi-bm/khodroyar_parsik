import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import 'parking_spots_table.dart';

part 'parking_spot_dao.g.dart';

@DriftAccessor(tables: [ParkingSpots])
class ParkingSpotDao extends DatabaseAccessor<AppDatabase>
    with _$ParkingSpotDaoMixin {
  ParkingSpotDao(super.db);

  Stream<ParkingSpot?> watchForVehicle(int vehicleId) =>
      (select(parkingSpots)..where((t) => t.vehicleId.equals(vehicleId)))
          .watchSingleOrNull();

  Future<int> insertSpot(ParkingSpotsCompanion entry) =>
      into(parkingSpots).insert(entry);

  Future<void> deleteForVehicle(int vehicleId) =>
      (delete(parkingSpots)..where((t) => t.vehicleId.equals(vehicleId))).go();
}
