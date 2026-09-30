import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/fuel/data/fuel_repository.dart';
import 'package:caryar/features/maintenance/data/maintenance_repository.dart';
import 'package:caryar/features/vehicles/data/vehicle_repository.dart';

void main() {
  test(
    'fuel and service records advance the odometer without historical regressions',
    () async {
      final db = AppDatabase.withExecutor(NativeDatabase.memory());
      addTearDown(db.close);
      final vehicles = VehicleRepository(db);
      final id = await vehicles.addVehicle(name: 'پژو', currentMileage: 1000);
      await FuelRepository(db).addRecord(
        vehicleId: id,
        date: DateTime.now(),
        mileage: 1500,
        fuelAmountLiters: 35,
        totalCost: 100000,
        isFullTank: true,
      );
      expect((await vehicles.getVehicle(id))!.currentMileage, 1500);
      final service = MaintenanceRepository(db);
      await service.addRecord(
        vehicleId: id,
        title: 'روغن',
        category: 'engineOil',
        date: DateTime.now(),
        mileage: 1200,
      );
      expect((await vehicles.getVehicle(id))!.currentMileage, 1500);
      await service.addRecord(
        vehicleId: id,
        title: 'روغن',
        category: 'engineOil',
        date: DateTime.now(),
        mileage: 2000,
      );
      expect((await vehicles.getVehicle(id))!.currentMileage, 2000);
    },
  );
}
