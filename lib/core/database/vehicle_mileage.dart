import 'package:drift/drift.dart';
import 'app_database.dart';

extension VehicleMileage on AppDatabase {
  /// A historical record must never move the current odometer backwards.
  Future<void> advanceMileage(int vehicleId, int mileage) async {
    await (update(vehicles)..where(
          (v) =>
              v.id.equals(vehicleId) &
              v.currentMileage.isSmallerThanValue(mileage),
        ))
        .write(
          VehiclesCompanion(
            currentMileage: Value(mileage),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }
}
