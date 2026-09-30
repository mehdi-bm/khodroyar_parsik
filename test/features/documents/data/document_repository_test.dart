import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/features/documents/data/document_repository.dart';
import 'package:caryar/features/vehicles/data/vehicle_repository.dart';

void main() {
  late AppDatabase db;
  late VehicleRepository vehicles;
  late DocumentRepository documents;
  late int vehicleId;

  setUp(() async {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
    vehicles = VehicleRepository(db);
    documents = DocumentRepository(db);
    vehicleId = await vehicles.addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 80000,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('documents show up ordered by expiration date, soonest first', () async {
    await documents.addDocument(
      vehicleId: vehicleId,
      title: 'معاینه فنی',
      type: 'inspection',
      expirationDate: DateTime(2026, 12, 1),
    );
    await documents.addDocument(
      vehicleId: vehicleId,
      title: 'بیمه شخص ثالث',
      type: 'insurance',
      expirationDate: DateTime(2026, 6, 1),
    );

    final saved = await documents.watchForVehicle(vehicleId).first;
    expect(saved, hasLength(2));
    expect(saved.first.title, 'بیمه شخص ثالث');
  });

  test('deleting a vehicle cascades to its documents', () async {
    await documents.addDocument(
      vehicleId: vehicleId,
      title: 'بیمه شخص ثالث',
      type: 'insurance',
      expirationDate: DateTime(2026, 6, 1),
    );

    await vehicles.deleteVehicle(vehicleId);

    expect(await documents.watchForVehicle(vehicleId).first, isEmpty);
  });

  test('only expirationDate is required — startDate stays null', () async {
    final id = await documents.addDocument(
      vehicleId: vehicleId,
      title: 'بیمه شخص ثالث',
      type: 'insurance',
      expirationDate: DateTime(2026, 6, 1),
    );

    final saved = await documents.getById(id);
    expect(saved?.startDate, isNull);
    expect(saved?.expirationDate, DateTime(2026, 6, 1));
  });

  test('updateDocument can clear an existing start date', () async {
    final id = await documents.addDocument(
      vehicleId: vehicleId,
      title: 'بیمه شخص ثالث',
      type: 'insurance',
      startDate: DateTime(2026, 1, 1),
      expirationDate: DateTime(2026, 6, 1),
    );

    await documents.updateDocument(
      id: id,
      vehicleId: vehicleId,
      title: 'بیمه شخص ثالث',
      type: 'insurance',
      startDate: null,
      expirationDate: DateTime(2026, 6, 1),
    );

    final saved = await documents.getById(id);
    expect(saved?.startDate, isNull);
  });
}
