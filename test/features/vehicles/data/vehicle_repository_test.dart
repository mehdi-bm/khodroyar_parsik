import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/vehicles/data/vehicle_repository.dart';

void main() {
  late AppDatabase db;
  late VehicleRepository repository;

  setUp(() {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
    repository = VehicleRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('active vehicle is null when there are no vehicles', () async {
    expect(await repository.watchActiveVehicle().first, isNull);
  });

  test('active vehicle falls back to the first vehicle by default', () async {
    final firstId = await repository.addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 1000,
    );
    await repository.addVehicle(name: 'دنا', currentMileage: 2000);

    final active = await repository.watchActiveVehicle().first;
    expect(active?.id, firstId);
  });

  test('setActiveVehicle switches the active vehicle', () async {
    await repository.addVehicle(name: 'پژو ۲۰۶', currentMileage: 1000);
    final secondId = await repository.addVehicle(
      name: 'دنا',
      currentMileage: 2000,
    );

    await repository.setActiveVehicle(secondId);

    final active = await repository.watchActiveVehicle().first;
    expect(active?.id, secondId);
  });

  test(
    'deleting the active vehicle falls back to a remaining vehicle',
    () async {
      final firstId = await repository.addVehicle(
        name: 'پژو ۲۰۶',
        currentMileage: 1000,
      );
      final secondId = await repository.addVehicle(
        name: 'دنا',
        currentMileage: 2000,
      );
      await repository.setActiveVehicle(firstId);

      await repository.deleteVehicle(firstId);

      final active = await repository.watchActiveVehicle().first;
      expect(active?.id, secondId);
    },
  );

  test('deleting the only vehicle leaves no active vehicle', () async {
    final onlyId = await repository.addVehicle(
      name: 'پراید',
      currentMileage: 500,
    );
    await repository.setActiveVehicle(onlyId);

    await repository.deleteVehicle(onlyId);

    expect(await repository.watchActiveVehicle().first, isNull);
  });

  test('updateVehicle persists changed fields', () async {
    final id = await repository.addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 1000,
    );

    await repository.updateVehicle(
      id: id,
      name: 'پژو ۲۰۶ تیپ ۲',
      currentMileage: 5000,
    );

    final updated = await repository.getVehicle(id);
    expect(updated?.name, 'پژو ۲۰۶ تیپ ۲');
    expect(updated?.currentMileage, 5000);
  });

  test('consumable-part specs are saved and updated', () async {
    final id = await repository.addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 1000,
      oilType: '5W-30 سینتتیک',
      tireSize: '185/65R15',
    );

    final saved = await repository.getVehicle(id);
    expect(saved?.oilType, '5W-30 سینتتیک');
    expect(saved?.tireSize, '185/65R15');
    expect(saved?.batteryModel, isNull);

    await repository.updateVehicle(
      id: id,
      name: 'پژو ۲۰۶',
      currentMileage: 1000,
      oilType: '5W-30 سینتتیک',
      tireSize: '185/65R15',
      batteryModel: 'وارتا ۶۰ آمپر',
    );

    final updated = await repository.getVehicle(id);
    expect(updated?.batteryModel, 'وارتا ۶۰ آمپر');
  });
}
