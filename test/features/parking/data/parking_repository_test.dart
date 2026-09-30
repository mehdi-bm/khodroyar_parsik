import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/parking/data/parking_repository.dart';
import 'package:caryar/features/vehicles/data/vehicle_repository.dart';

void main() {
  late AppDatabase db;
  late ParkingRepository repository;
  late VehicleRepository vehicles;
  late int vehicleId;

  setUp(() async {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
    repository = ParkingRepository(db);
    vehicles = VehicleRepository(db);
    vehicleId = await vehicles.addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 1000,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('no spot saved yet returns null', () async {
    expect(await repository.watchForVehicle(vehicleId).first, isNull);
  });

  test('saveSpot persists coordinates and note', () async {
    await repository.saveSpot(
      vehicleId: vehicleId,
      latitude: 35.7,
      longitude: 51.4,
      note: 'طبقه دوم',
    );

    final spot = await repository.watchForVehicle(vehicleId).first;
    expect(spot?.latitude, 35.7);
    expect(spot?.longitude, 51.4);
    expect(spot?.note, 'طبقه دوم');
  });

  test('saving again replaces the previous spot, not appends', () async {
    await repository.saveSpot(vehicleId: vehicleId, note: 'اول');
    await repository.saveSpot(vehicleId: vehicleId, note: 'دوم');

    final spot = await repository.watchForVehicle(vehicleId).first;
    expect(spot?.note, 'دوم');
  });

  test('clearSpot removes the saved spot', () async {
    await repository.saveSpot(vehicleId: vehicleId, note: 'یک جایی');
    await repository.clearSpot(vehicleId);

    expect(await repository.watchForVehicle(vehicleId).first, isNull);
  });

  test('spots are scoped per vehicle', () async {
    final otherVehicleId = await vehicles.addVehicle(
      name: 'دنا',
      currentMileage: 2000,
    );
    await repository.saveSpot(vehicleId: vehicleId, note: 'خودروی اول');
    await repository.saveSpot(vehicleId: otherVehicleId, note: 'خودروی دوم');

    final first = await repository.watchForVehicle(vehicleId).first;
    final second = await repository.watchForVehicle(otherVehicleId).first;
    expect(first?.note, 'خودروی اول');
    expect(second?.note, 'خودروی دوم');
  });
}
