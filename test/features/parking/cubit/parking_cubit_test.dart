import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/parking/cubit/parking_cubit.dart';
import 'package:caryar/features/parking/data/location_provider.dart';
import 'package:caryar/features/parking/data/parking_repository.dart';
import 'package:caryar/features/parking/domain/location_result.dart';
import 'package:caryar/features/vehicles/data/vehicle_repository.dart';

class _FakeLocationProvider implements LocationProvider {
  LocationResult result = const LocationSuccess(latitude: 35.7, longitude: 51.4);

  @override
  Future<LocationResult> getCurrentLocation() async => result;
}

void main() {
  late AppDatabase db;
  late ParkingRepository repository;
  late _FakeLocationProvider locationProvider;
  late int vehicleId;

  setUp(() async {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
    repository = ParkingRepository(db);
    locationProvider = _FakeLocationProvider();
    final vehicles = VehicleRepository(db);
    vehicleId = await vehicles.addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 1000,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('save() with a successful GPS fix stores coordinates', () async {
    final cubit = ParkingCubit(repository, locationProvider)..watch(vehicleId);

    await cubit.save(note: 'نزدیک درب شرقی');
    // save() only writes to the DB — state.spot updates via the reactive
    // watch() stream, which emits on a later microtask/timer tick.
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.spot?.latitude, 35.7);
    expect(cubit.state.spot?.note, 'نزدیک درب شرقی');
    expect(cubit.state.errorMessage, isNull);
    await cubit.close();
  });

  test(
    'save() with a failed GPS fix still saves the note, with an error message',
    () async {
      locationProvider.result = const LocationFailure(
        LocationFailureReason.permissionDenied,
      );
      final cubit = ParkingCubit(repository, locationProvider)
        ..watch(vehicleId);

      await cubit.save(note: 'نزدیک درب شرقی');
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.spot?.latitude, isNull);
      expect(cubit.state.spot?.note, 'نزدیک درب شرقی');
      expect(cubit.state.errorMessage, isNotNull);
      await cubit.close();
    },
  );

  test('clear() removes the saved spot', () async {
    final cubit = ParkingCubit(repository, locationProvider)..watch(vehicleId);
    await cubit.save(note: 'یک جایی');
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.spot, isNotNull);

    await cubit.clear();
    // The repository's watch stream needs a tick to propagate the delete.
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.spot, isNull);
    await cubit.close();
  });

  test('watch() reflects a spot already saved before the cubit existed', () async {
    await repository.saveSpot(vehicleId: vehicleId, note: 'ذخیره قبلی');

    final cubit = ParkingCubit(repository, locationProvider)..watch(vehicleId);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.spot?.note, 'ذخیره قبلی');
    expect(cubit.state.loading, isFalse);
    await cubit.close();
  });
}
