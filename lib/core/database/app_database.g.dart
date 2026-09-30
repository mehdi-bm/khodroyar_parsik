// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelYearMeta = const VerificationMeta(
    'modelYear',
  );
  @override
  late final GeneratedColumn<int> modelYear = GeneratedColumn<int>(
    'model_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _licensePlateMeta = const VerificationMeta(
    'licensePlate',
  );
  @override
  late final GeneratedColumn<String> licensePlate = GeneratedColumn<String>(
    'license_plate',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentMileageMeta = const VerificationMeta(
    'currentMileage',
  );
  @override
  late final GeneratedColumn<int> currentMileage = GeneratedColumn<int>(
    'current_mileage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _oilTypeMeta = const VerificationMeta(
    'oilType',
  );
  @override
  late final GeneratedColumn<String> oilType = GeneratedColumn<String>(
    'oil_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _oilFilterModelMeta = const VerificationMeta(
    'oilFilterModel',
  );
  @override
  late final GeneratedColumn<String> oilFilterModel = GeneratedColumn<String>(
    'oil_filter_model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _airFilterModelMeta = const VerificationMeta(
    'airFilterModel',
  );
  @override
  late final GeneratedColumn<String> airFilterModel = GeneratedColumn<String>(
    'air_filter_model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cabinFilterModelMeta = const VerificationMeta(
    'cabinFilterModel',
  );
  @override
  late final GeneratedColumn<String> cabinFilterModel = GeneratedColumn<String>(
    'cabin_filter_model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tireSizeMeta = const VerificationMeta(
    'tireSize',
  );
  @override
  late final GeneratedColumn<String> tireSize = GeneratedColumn<String>(
    'tire_size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _batteryModelMeta = const VerificationMeta(
    'batteryModel',
  );
  @override
  late final GeneratedColumn<String> batteryModel = GeneratedColumn<String>(
    'battery_model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sparkPlugModelMeta = const VerificationMeta(
    'sparkPlugModel',
  );
  @override
  late final GeneratedColumn<String> sparkPlugModel = GeneratedColumn<String>(
    'spark_plug_model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    brand,
    model,
    modelYear,
    color,
    licensePlate,
    currentMileage,
    photoPath,
    notes,
    createdAt,
    updatedAt,
    oilType,
    oilFilterModel,
    airFilterModel,
    cabinFilterModel,
    tireSize,
    batteryModel,
    sparkPlugModel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vehicle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('model_year')) {
      context.handle(
        _modelYearMeta,
        modelYear.isAcceptableOrUnknown(data['model_year']!, _modelYearMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('license_plate')) {
      context.handle(
        _licensePlateMeta,
        licensePlate.isAcceptableOrUnknown(
          data['license_plate']!,
          _licensePlateMeta,
        ),
      );
    }
    if (data.containsKey('current_mileage')) {
      context.handle(
        _currentMileageMeta,
        currentMileage.isAcceptableOrUnknown(
          data['current_mileage']!,
          _currentMileageMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('oil_type')) {
      context.handle(
        _oilTypeMeta,
        oilType.isAcceptableOrUnknown(data['oil_type']!, _oilTypeMeta),
      );
    }
    if (data.containsKey('oil_filter_model')) {
      context.handle(
        _oilFilterModelMeta,
        oilFilterModel.isAcceptableOrUnknown(
          data['oil_filter_model']!,
          _oilFilterModelMeta,
        ),
      );
    }
    if (data.containsKey('air_filter_model')) {
      context.handle(
        _airFilterModelMeta,
        airFilterModel.isAcceptableOrUnknown(
          data['air_filter_model']!,
          _airFilterModelMeta,
        ),
      );
    }
    if (data.containsKey('cabin_filter_model')) {
      context.handle(
        _cabinFilterModelMeta,
        cabinFilterModel.isAcceptableOrUnknown(
          data['cabin_filter_model']!,
          _cabinFilterModelMeta,
        ),
      );
    }
    if (data.containsKey('tire_size')) {
      context.handle(
        _tireSizeMeta,
        tireSize.isAcceptableOrUnknown(data['tire_size']!, _tireSizeMeta),
      );
    }
    if (data.containsKey('battery_model')) {
      context.handle(
        _batteryModelMeta,
        batteryModel.isAcceptableOrUnknown(
          data['battery_model']!,
          _batteryModelMeta,
        ),
      );
    }
    if (data.containsKey('spark_plug_model')) {
      context.handle(
        _sparkPlugModelMeta,
        sparkPlugModel.isAcceptableOrUnknown(
          data['spark_plug_model']!,
          _sparkPlugModelMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      modelYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}model_year'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      licensePlate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_plate'],
      ),
      currentMileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_mileage'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      oilType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}oil_type'],
      ),
      oilFilterModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}oil_filter_model'],
      ),
      airFilterModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}air_filter_model'],
      ),
      cabinFilterModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cabin_filter_model'],
      ),
      tireSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tire_size'],
      ),
      batteryModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}battery_model'],
      ),
      sparkPlugModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spark_plug_model'],
      ),
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  final int id;
  final String name;
  final String? brand;
  final String? model;
  final int? modelYear;
  final String? color;
  final String? licensePlate;
  final int currentMileage;
  final String? photoPath;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? oilType;
  final String? oilFilterModel;
  final String? airFilterModel;
  final String? cabinFilterModel;
  final String? tireSize;
  final String? batteryModel;
  final String? sparkPlugModel;
  const Vehicle({
    required this.id,
    required this.name,
    this.brand,
    this.model,
    this.modelYear,
    this.color,
    this.licensePlate,
    required this.currentMileage,
    this.photoPath,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.oilType,
    this.oilFilterModel,
    this.airFilterModel,
    this.cabinFilterModel,
    this.tireSize,
    this.batteryModel,
    this.sparkPlugModel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || modelYear != null) {
      map['model_year'] = Variable<int>(modelYear);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || licensePlate != null) {
      map['license_plate'] = Variable<String>(licensePlate);
    }
    map['current_mileage'] = Variable<int>(currentMileage);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || oilType != null) {
      map['oil_type'] = Variable<String>(oilType);
    }
    if (!nullToAbsent || oilFilterModel != null) {
      map['oil_filter_model'] = Variable<String>(oilFilterModel);
    }
    if (!nullToAbsent || airFilterModel != null) {
      map['air_filter_model'] = Variable<String>(airFilterModel);
    }
    if (!nullToAbsent || cabinFilterModel != null) {
      map['cabin_filter_model'] = Variable<String>(cabinFilterModel);
    }
    if (!nullToAbsent || tireSize != null) {
      map['tire_size'] = Variable<String>(tireSize);
    }
    if (!nullToAbsent || batteryModel != null) {
      map['battery_model'] = Variable<String>(batteryModel);
    }
    if (!nullToAbsent || sparkPlugModel != null) {
      map['spark_plug_model'] = Variable<String>(sparkPlugModel);
    }
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      name: Value(name),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      model: model == null && nullToAbsent
          ? const Value.absent()
          : Value(model),
      modelYear: modelYear == null && nullToAbsent
          ? const Value.absent()
          : Value(modelYear),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      licensePlate: licensePlate == null && nullToAbsent
          ? const Value.absent()
          : Value(licensePlate),
      currentMileage: Value(currentMileage),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      oilType: oilType == null && nullToAbsent
          ? const Value.absent()
          : Value(oilType),
      oilFilterModel: oilFilterModel == null && nullToAbsent
          ? const Value.absent()
          : Value(oilFilterModel),
      airFilterModel: airFilterModel == null && nullToAbsent
          ? const Value.absent()
          : Value(airFilterModel),
      cabinFilterModel: cabinFilterModel == null && nullToAbsent
          ? const Value.absent()
          : Value(cabinFilterModel),
      tireSize: tireSize == null && nullToAbsent
          ? const Value.absent()
          : Value(tireSize),
      batteryModel: batteryModel == null && nullToAbsent
          ? const Value.absent()
          : Value(batteryModel),
      sparkPlugModel: sparkPlugModel == null && nullToAbsent
          ? const Value.absent()
          : Value(sparkPlugModel),
    );
  }

  factory Vehicle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      brand: serializer.fromJson<String?>(json['brand']),
      model: serializer.fromJson<String?>(json['model']),
      modelYear: serializer.fromJson<int?>(json['modelYear']),
      color: serializer.fromJson<String?>(json['color']),
      licensePlate: serializer.fromJson<String?>(json['licensePlate']),
      currentMileage: serializer.fromJson<int>(json['currentMileage']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      oilType: serializer.fromJson<String?>(json['oilType']),
      oilFilterModel: serializer.fromJson<String?>(json['oilFilterModel']),
      airFilterModel: serializer.fromJson<String?>(json['airFilterModel']),
      cabinFilterModel: serializer.fromJson<String?>(json['cabinFilterModel']),
      tireSize: serializer.fromJson<String?>(json['tireSize']),
      batteryModel: serializer.fromJson<String?>(json['batteryModel']),
      sparkPlugModel: serializer.fromJson<String?>(json['sparkPlugModel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'brand': serializer.toJson<String?>(brand),
      'model': serializer.toJson<String?>(model),
      'modelYear': serializer.toJson<int?>(modelYear),
      'color': serializer.toJson<String?>(color),
      'licensePlate': serializer.toJson<String?>(licensePlate),
      'currentMileage': serializer.toJson<int>(currentMileage),
      'photoPath': serializer.toJson<String?>(photoPath),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'oilType': serializer.toJson<String?>(oilType),
      'oilFilterModel': serializer.toJson<String?>(oilFilterModel),
      'airFilterModel': serializer.toJson<String?>(airFilterModel),
      'cabinFilterModel': serializer.toJson<String?>(cabinFilterModel),
      'tireSize': serializer.toJson<String?>(tireSize),
      'batteryModel': serializer.toJson<String?>(batteryModel),
      'sparkPlugModel': serializer.toJson<String?>(sparkPlugModel),
    };
  }

  Vehicle copyWith({
    int? id,
    String? name,
    Value<String?> brand = const Value.absent(),
    Value<String?> model = const Value.absent(),
    Value<int?> modelYear = const Value.absent(),
    Value<String?> color = const Value.absent(),
    Value<String?> licensePlate = const Value.absent(),
    int? currentMileage,
    Value<String?> photoPath = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> oilType = const Value.absent(),
    Value<String?> oilFilterModel = const Value.absent(),
    Value<String?> airFilterModel = const Value.absent(),
    Value<String?> cabinFilterModel = const Value.absent(),
    Value<String?> tireSize = const Value.absent(),
    Value<String?> batteryModel = const Value.absent(),
    Value<String?> sparkPlugModel = const Value.absent(),
  }) => Vehicle(
    id: id ?? this.id,
    name: name ?? this.name,
    brand: brand.present ? brand.value : this.brand,
    model: model.present ? model.value : this.model,
    modelYear: modelYear.present ? modelYear.value : this.modelYear,
    color: color.present ? color.value : this.color,
    licensePlate: licensePlate.present ? licensePlate.value : this.licensePlate,
    currentMileage: currentMileage ?? this.currentMileage,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    oilType: oilType.present ? oilType.value : this.oilType,
    oilFilterModel: oilFilterModel.present
        ? oilFilterModel.value
        : this.oilFilterModel,
    airFilterModel: airFilterModel.present
        ? airFilterModel.value
        : this.airFilterModel,
    cabinFilterModel: cabinFilterModel.present
        ? cabinFilterModel.value
        : this.cabinFilterModel,
    tireSize: tireSize.present ? tireSize.value : this.tireSize,
    batteryModel: batteryModel.present ? batteryModel.value : this.batteryModel,
    sparkPlugModel: sparkPlugModel.present
        ? sparkPlugModel.value
        : this.sparkPlugModel,
  );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      modelYear: data.modelYear.present ? data.modelYear.value : this.modelYear,
      color: data.color.present ? data.color.value : this.color,
      licensePlate: data.licensePlate.present
          ? data.licensePlate.value
          : this.licensePlate,
      currentMileage: data.currentMileage.present
          ? data.currentMileage.value
          : this.currentMileage,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      oilType: data.oilType.present ? data.oilType.value : this.oilType,
      oilFilterModel: data.oilFilterModel.present
          ? data.oilFilterModel.value
          : this.oilFilterModel,
      airFilterModel: data.airFilterModel.present
          ? data.airFilterModel.value
          : this.airFilterModel,
      cabinFilterModel: data.cabinFilterModel.present
          ? data.cabinFilterModel.value
          : this.cabinFilterModel,
      tireSize: data.tireSize.present ? data.tireSize.value : this.tireSize,
      batteryModel: data.batteryModel.present
          ? data.batteryModel.value
          : this.batteryModel,
      sparkPlugModel: data.sparkPlugModel.present
          ? data.sparkPlugModel.value
          : this.sparkPlugModel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('modelYear: $modelYear, ')
          ..write('color: $color, ')
          ..write('licensePlate: $licensePlate, ')
          ..write('currentMileage: $currentMileage, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('oilType: $oilType, ')
          ..write('oilFilterModel: $oilFilterModel, ')
          ..write('airFilterModel: $airFilterModel, ')
          ..write('cabinFilterModel: $cabinFilterModel, ')
          ..write('tireSize: $tireSize, ')
          ..write('batteryModel: $batteryModel, ')
          ..write('sparkPlugModel: $sparkPlugModel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    brand,
    model,
    modelYear,
    color,
    licensePlate,
    currentMileage,
    photoPath,
    notes,
    createdAt,
    updatedAt,
    oilType,
    oilFilterModel,
    airFilterModel,
    cabinFilterModel,
    tireSize,
    batteryModel,
    sparkPlugModel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.id == this.id &&
          other.name == this.name &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.modelYear == this.modelYear &&
          other.color == this.color &&
          other.licensePlate == this.licensePlate &&
          other.currentMileage == this.currentMileage &&
          other.photoPath == this.photoPath &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.oilType == this.oilType &&
          other.oilFilterModel == this.oilFilterModel &&
          other.airFilterModel == this.airFilterModel &&
          other.cabinFilterModel == this.cabinFilterModel &&
          other.tireSize == this.tireSize &&
          other.batteryModel == this.batteryModel &&
          other.sparkPlugModel == this.sparkPlugModel);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> brand;
  final Value<String?> model;
  final Value<int?> modelYear;
  final Value<String?> color;
  final Value<String?> licensePlate;
  final Value<int> currentMileage;
  final Value<String?> photoPath;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> oilType;
  final Value<String?> oilFilterModel;
  final Value<String?> airFilterModel;
  final Value<String?> cabinFilterModel;
  final Value<String?> tireSize;
  final Value<String?> batteryModel;
  final Value<String?> sparkPlugModel;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.modelYear = const Value.absent(),
    this.color = const Value.absent(),
    this.licensePlate = const Value.absent(),
    this.currentMileage = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.oilType = const Value.absent(),
    this.oilFilterModel = const Value.absent(),
    this.airFilterModel = const Value.absent(),
    this.cabinFilterModel = const Value.absent(),
    this.tireSize = const Value.absent(),
    this.batteryModel = const Value.absent(),
    this.sparkPlugModel = const Value.absent(),
  });
  VehiclesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.modelYear = const Value.absent(),
    this.color = const Value.absent(),
    this.licensePlate = const Value.absent(),
    this.currentMileage = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.oilType = const Value.absent(),
    this.oilFilterModel = const Value.absent(),
    this.airFilterModel = const Value.absent(),
    this.cabinFilterModel = const Value.absent(),
    this.tireSize = const Value.absent(),
    this.batteryModel = const Value.absent(),
    this.sparkPlugModel = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Vehicle> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<int>? modelYear,
    Expression<String>? color,
    Expression<String>? licensePlate,
    Expression<int>? currentMileage,
    Expression<String>? photoPath,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? oilType,
    Expression<String>? oilFilterModel,
    Expression<String>? airFilterModel,
    Expression<String>? cabinFilterModel,
    Expression<String>? tireSize,
    Expression<String>? batteryModel,
    Expression<String>? sparkPlugModel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (modelYear != null) 'model_year': modelYear,
      if (color != null) 'color': color,
      if (licensePlate != null) 'license_plate': licensePlate,
      if (currentMileage != null) 'current_mileage': currentMileage,
      if (photoPath != null) 'photo_path': photoPath,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (oilType != null) 'oil_type': oilType,
      if (oilFilterModel != null) 'oil_filter_model': oilFilterModel,
      if (airFilterModel != null) 'air_filter_model': airFilterModel,
      if (cabinFilterModel != null) 'cabin_filter_model': cabinFilterModel,
      if (tireSize != null) 'tire_size': tireSize,
      if (batteryModel != null) 'battery_model': batteryModel,
      if (sparkPlugModel != null) 'spark_plug_model': sparkPlugModel,
    });
  }

  VehiclesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? brand,
    Value<String?>? model,
    Value<int?>? modelYear,
    Value<String?>? color,
    Value<String?>? licensePlate,
    Value<int>? currentMileage,
    Value<String?>? photoPath,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? oilType,
    Value<String?>? oilFilterModel,
    Value<String?>? airFilterModel,
    Value<String?>? cabinFilterModel,
    Value<String?>? tireSize,
    Value<String?>? batteryModel,
    Value<String?>? sparkPlugModel,
  }) {
    return VehiclesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      modelYear: modelYear ?? this.modelYear,
      color: color ?? this.color,
      licensePlate: licensePlate ?? this.licensePlate,
      currentMileage: currentMileage ?? this.currentMileage,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      oilType: oilType ?? this.oilType,
      oilFilterModel: oilFilterModel ?? this.oilFilterModel,
      airFilterModel: airFilterModel ?? this.airFilterModel,
      cabinFilterModel: cabinFilterModel ?? this.cabinFilterModel,
      tireSize: tireSize ?? this.tireSize,
      batteryModel: batteryModel ?? this.batteryModel,
      sparkPlugModel: sparkPlugModel ?? this.sparkPlugModel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (modelYear.present) {
      map['model_year'] = Variable<int>(modelYear.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (licensePlate.present) {
      map['license_plate'] = Variable<String>(licensePlate.value);
    }
    if (currentMileage.present) {
      map['current_mileage'] = Variable<int>(currentMileage.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (oilType.present) {
      map['oil_type'] = Variable<String>(oilType.value);
    }
    if (oilFilterModel.present) {
      map['oil_filter_model'] = Variable<String>(oilFilterModel.value);
    }
    if (airFilterModel.present) {
      map['air_filter_model'] = Variable<String>(airFilterModel.value);
    }
    if (cabinFilterModel.present) {
      map['cabin_filter_model'] = Variable<String>(cabinFilterModel.value);
    }
    if (tireSize.present) {
      map['tire_size'] = Variable<String>(tireSize.value);
    }
    if (batteryModel.present) {
      map['battery_model'] = Variable<String>(batteryModel.value);
    }
    if (sparkPlugModel.present) {
      map['spark_plug_model'] = Variable<String>(sparkPlugModel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('modelYear: $modelYear, ')
          ..write('color: $color, ')
          ..write('licensePlate: $licensePlate, ')
          ..write('currentMileage: $currentMileage, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('oilType: $oilType, ')
          ..write('oilFilterModel: $oilFilterModel, ')
          ..write('airFilterModel: $airFilterModel, ')
          ..write('cabinFilterModel: $cabinFilterModel, ')
          ..write('tireSize: $tireSize, ')
          ..write('batteryModel: $batteryModel, ')
          ..write('sparkPlugModel: $sparkPlugModel')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceRecordsTable extends MaintenanceRecords
    with TableInfo<$MaintenanceRecordsTable, MaintenanceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mileageMeta = const VerificationMeta(
    'mileage',
  );
  @override
  late final GeneratedColumn<int> mileage = GeneratedColumn<int>(
    'mileage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<int> cost = GeneratedColumn<int>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextServiceMileageMeta =
      const VerificationMeta('nextServiceMileage');
  @override
  late final GeneratedColumn<int> nextServiceMileage = GeneratedColumn<int>(
    'next_service_mileage',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextServiceDateMeta = const VerificationMeta(
    'nextServiceDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextServiceDate =
      GeneratedColumn<DateTime>(
        'next_service_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    title,
    category,
    date,
    mileage,
    cost,
    description,
    photoPath,
    nextServiceMileage,
    nextServiceDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('mileage')) {
      context.handle(
        _mileageMeta,
        mileage.isAcceptableOrUnknown(data['mileage']!, _mileageMeta),
      );
    } else if (isInserting) {
      context.missing(_mileageMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('next_service_mileage')) {
      context.handle(
        _nextServiceMileageMeta,
        nextServiceMileage.isAcceptableOrUnknown(
          data['next_service_mileage']!,
          _nextServiceMileageMeta,
        ),
      );
    }
    if (data.containsKey('next_service_date')) {
      context.handle(
        _nextServiceDateMeta,
        nextServiceDate.isAcceptableOrUnknown(
          data['next_service_date']!,
          _nextServiceDateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      mileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mileage'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      nextServiceMileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_service_mileage'],
      ),
      nextServiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_service_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MaintenanceRecordsTable createAlias(String alias) {
    return $MaintenanceRecordsTable(attachedDatabase, alias);
  }
}

class MaintenanceRecord extends DataClass
    implements Insertable<MaintenanceRecord> {
  final int id;
  final int vehicleId;
  final String title;
  final String category;
  final DateTime date;
  final int mileage;
  final int cost;
  final String? description;
  final String? photoPath;
  final int? nextServiceMileage;
  final DateTime? nextServiceDate;
  final DateTime createdAt;
  const MaintenanceRecord({
    required this.id,
    required this.vehicleId,
    required this.title,
    required this.category,
    required this.date,
    required this.mileage,
    required this.cost,
    this.description,
    this.photoPath,
    this.nextServiceMileage,
    this.nextServiceDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['date'] = Variable<DateTime>(date);
    map['mileage'] = Variable<int>(mileage);
    map['cost'] = Variable<int>(cost);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || nextServiceMileage != null) {
      map['next_service_mileage'] = Variable<int>(nextServiceMileage);
    }
    if (!nullToAbsent || nextServiceDate != null) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MaintenanceRecordsCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceRecordsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      title: Value(title),
      category: Value(category),
      date: Value(date),
      mileage: Value(mileage),
      cost: Value(cost),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      nextServiceMileage: nextServiceMileage == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceMileage),
      nextServiceDate: nextServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceDate),
      createdAt: Value(createdAt),
    );
  }

  factory MaintenanceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceRecord(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      date: serializer.fromJson<DateTime>(json['date']),
      mileage: serializer.fromJson<int>(json['mileage']),
      cost: serializer.fromJson<int>(json['cost']),
      description: serializer.fromJson<String?>(json['description']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      nextServiceMileage: serializer.fromJson<int?>(json['nextServiceMileage']),
      nextServiceDate: serializer.fromJson<DateTime?>(json['nextServiceDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'date': serializer.toJson<DateTime>(date),
      'mileage': serializer.toJson<int>(mileage),
      'cost': serializer.toJson<int>(cost),
      'description': serializer.toJson<String?>(description),
      'photoPath': serializer.toJson<String?>(photoPath),
      'nextServiceMileage': serializer.toJson<int?>(nextServiceMileage),
      'nextServiceDate': serializer.toJson<DateTime?>(nextServiceDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MaintenanceRecord copyWith({
    int? id,
    int? vehicleId,
    String? title,
    String? category,
    DateTime? date,
    int? mileage,
    int? cost,
    Value<String?> description = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    Value<int?> nextServiceMileage = const Value.absent(),
    Value<DateTime?> nextServiceDate = const Value.absent(),
    DateTime? createdAt,
  }) => MaintenanceRecord(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    title: title ?? this.title,
    category: category ?? this.category,
    date: date ?? this.date,
    mileage: mileage ?? this.mileage,
    cost: cost ?? this.cost,
    description: description.present ? description.value : this.description,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    nextServiceMileage: nextServiceMileage.present
        ? nextServiceMileage.value
        : this.nextServiceMileage,
    nextServiceDate: nextServiceDate.present
        ? nextServiceDate.value
        : this.nextServiceDate,
    createdAt: createdAt ?? this.createdAt,
  );
  MaintenanceRecord copyWithCompanion(MaintenanceRecordsCompanion data) {
    return MaintenanceRecord(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      date: data.date.present ? data.date.value : this.date,
      mileage: data.mileage.present ? data.mileage.value : this.mileage,
      cost: data.cost.present ? data.cost.value : this.cost,
      description: data.description.present
          ? data.description.value
          : this.description,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      nextServiceMileage: data.nextServiceMileage.present
          ? data.nextServiceMileage.value
          : this.nextServiceMileage,
      nextServiceDate: data.nextServiceDate.present
          ? data.nextServiceDate.value
          : this.nextServiceDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceRecord(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('mileage: $mileage, ')
          ..write('cost: $cost, ')
          ..write('description: $description, ')
          ..write('photoPath: $photoPath, ')
          ..write('nextServiceMileage: $nextServiceMileage, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    title,
    category,
    date,
    mileage,
    cost,
    description,
    photoPath,
    nextServiceMileage,
    nextServiceDate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceRecord &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.title == this.title &&
          other.category == this.category &&
          other.date == this.date &&
          other.mileage == this.mileage &&
          other.cost == this.cost &&
          other.description == this.description &&
          other.photoPath == this.photoPath &&
          other.nextServiceMileage == this.nextServiceMileage &&
          other.nextServiceDate == this.nextServiceDate &&
          other.createdAt == this.createdAt);
}

class MaintenanceRecordsCompanion extends UpdateCompanion<MaintenanceRecord> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> title;
  final Value<String> category;
  final Value<DateTime> date;
  final Value<int> mileage;
  final Value<int> cost;
  final Value<String?> description;
  final Value<String?> photoPath;
  final Value<int?> nextServiceMileage;
  final Value<DateTime?> nextServiceDate;
  final Value<DateTime> createdAt;
  const MaintenanceRecordsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.date = const Value.absent(),
    this.mileage = const Value.absent(),
    this.cost = const Value.absent(),
    this.description = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.nextServiceMileage = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MaintenanceRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String title,
    required String category,
    required DateTime date,
    required int mileage,
    this.cost = const Value.absent(),
    this.description = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.nextServiceMileage = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       title = Value(title),
       category = Value(category),
       date = Value(date),
       mileage = Value(mileage);
  static Insertable<MaintenanceRecord> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? title,
    Expression<String>? category,
    Expression<DateTime>? date,
    Expression<int>? mileage,
    Expression<int>? cost,
    Expression<String>? description,
    Expression<String>? photoPath,
    Expression<int>? nextServiceMileage,
    Expression<DateTime>? nextServiceDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (date != null) 'date': date,
      if (mileage != null) 'mileage': mileage,
      if (cost != null) 'cost': cost,
      if (description != null) 'description': description,
      if (photoPath != null) 'photo_path': photoPath,
      if (nextServiceMileage != null)
        'next_service_mileage': nextServiceMileage,
      if (nextServiceDate != null) 'next_service_date': nextServiceDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MaintenanceRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? title,
    Value<String>? category,
    Value<DateTime>? date,
    Value<int>? mileage,
    Value<int>? cost,
    Value<String?>? description,
    Value<String?>? photoPath,
    Value<int?>? nextServiceMileage,
    Value<DateTime?>? nextServiceDate,
    Value<DateTime>? createdAt,
  }) {
    return MaintenanceRecordsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      title: title ?? this.title,
      category: category ?? this.category,
      date: date ?? this.date,
      mileage: mileage ?? this.mileage,
      cost: cost ?? this.cost,
      description: description ?? this.description,
      photoPath: photoPath ?? this.photoPath,
      nextServiceMileage: nextServiceMileage ?? this.nextServiceMileage,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (mileage.present) {
      map['mileage'] = Variable<int>(mileage.value);
    }
    if (cost.present) {
      map['cost'] = Variable<int>(cost.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (nextServiceMileage.present) {
      map['next_service_mileage'] = Variable<int>(nextServiceMileage.value);
    }
    if (nextServiceDate.present) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('mileage: $mileage, ')
          ..write('cost: $cost, ')
          ..write('description: $description, ')
          ..write('photoPath: $photoPath, ')
          ..write('nextServiceMileage: $nextServiceMileage, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceSchedulesTable extends MaintenanceSchedules
    with TableInfo<$MaintenanceSchedulesTable, MaintenanceSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalMileageMeta = const VerificationMeta(
    'intervalMileage',
  );
  @override
  late final GeneratedColumn<int> intervalMileage = GeneratedColumn<int>(
    'interval_mileage',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastServiceMileageMeta =
      const VerificationMeta('lastServiceMileage');
  @override
  late final GeneratedColumn<int> lastServiceMileage = GeneratedColumn<int>(
    'last_service_mileage',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastServiceDateMeta = const VerificationMeta(
    'lastServiceDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastServiceDate =
      GeneratedColumn<DateTime>(
        'last_service_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    title,
    category,
    intervalMileage,
    intervalDays,
    lastServiceMileage,
    lastServiceDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceSchedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('interval_mileage')) {
      context.handle(
        _intervalMileageMeta,
        intervalMileage.isAcceptableOrUnknown(
          data['interval_mileage']!,
          _intervalMileageMeta,
        ),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('last_service_mileage')) {
      context.handle(
        _lastServiceMileageMeta,
        lastServiceMileage.isAcceptableOrUnknown(
          data['last_service_mileage']!,
          _lastServiceMileageMeta,
        ),
      );
    }
    if (data.containsKey('last_service_date')) {
      context.handle(
        _lastServiceDateMeta,
        lastServiceDate.isAcceptableOrUnknown(
          data['last_service_date']!,
          _lastServiceDateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceSchedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      intervalMileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_mileage'],
      ),
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      ),
      lastServiceMileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_service_mileage'],
      ),
      lastServiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_service_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MaintenanceSchedulesTable createAlias(String alias) {
    return $MaintenanceSchedulesTable(attachedDatabase, alias);
  }
}

class MaintenanceSchedule extends DataClass
    implements Insertable<MaintenanceSchedule> {
  final int id;
  final int vehicleId;
  final String title;
  final String category;
  final int? intervalMileage;
  final int? intervalDays;
  final int? lastServiceMileage;
  final DateTime? lastServiceDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MaintenanceSchedule({
    required this.id,
    required this.vehicleId,
    required this.title,
    required this.category,
    this.intervalMileage,
    this.intervalDays,
    this.lastServiceMileage,
    this.lastServiceDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || intervalMileage != null) {
      map['interval_mileage'] = Variable<int>(intervalMileage);
    }
    if (!nullToAbsent || intervalDays != null) {
      map['interval_days'] = Variable<int>(intervalDays);
    }
    if (!nullToAbsent || lastServiceMileage != null) {
      map['last_service_mileage'] = Variable<int>(lastServiceMileage);
    }
    if (!nullToAbsent || lastServiceDate != null) {
      map['last_service_date'] = Variable<DateTime>(lastServiceDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MaintenanceSchedulesCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceSchedulesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      title: Value(title),
      category: Value(category),
      intervalMileage: intervalMileage == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalMileage),
      intervalDays: intervalDays == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalDays),
      lastServiceMileage: lastServiceMileage == null && nullToAbsent
          ? const Value.absent()
          : Value(lastServiceMileage),
      lastServiceDate: lastServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastServiceDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MaintenanceSchedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceSchedule(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      intervalMileage: serializer.fromJson<int?>(json['intervalMileage']),
      intervalDays: serializer.fromJson<int?>(json['intervalDays']),
      lastServiceMileage: serializer.fromJson<int?>(json['lastServiceMileage']),
      lastServiceDate: serializer.fromJson<DateTime?>(json['lastServiceDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'intervalMileage': serializer.toJson<int?>(intervalMileage),
      'intervalDays': serializer.toJson<int?>(intervalDays),
      'lastServiceMileage': serializer.toJson<int?>(lastServiceMileage),
      'lastServiceDate': serializer.toJson<DateTime?>(lastServiceDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MaintenanceSchedule copyWith({
    int? id,
    int? vehicleId,
    String? title,
    String? category,
    Value<int?> intervalMileage = const Value.absent(),
    Value<int?> intervalDays = const Value.absent(),
    Value<int?> lastServiceMileage = const Value.absent(),
    Value<DateTime?> lastServiceDate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MaintenanceSchedule(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    title: title ?? this.title,
    category: category ?? this.category,
    intervalMileage: intervalMileage.present
        ? intervalMileage.value
        : this.intervalMileage,
    intervalDays: intervalDays.present ? intervalDays.value : this.intervalDays,
    lastServiceMileage: lastServiceMileage.present
        ? lastServiceMileage.value
        : this.lastServiceMileage,
    lastServiceDate: lastServiceDate.present
        ? lastServiceDate.value
        : this.lastServiceDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MaintenanceSchedule copyWithCompanion(MaintenanceSchedulesCompanion data) {
    return MaintenanceSchedule(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      intervalMileage: data.intervalMileage.present
          ? data.intervalMileage.value
          : this.intervalMileage,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      lastServiceMileage: data.lastServiceMileage.present
          ? data.lastServiceMileage.value
          : this.lastServiceMileage,
      lastServiceDate: data.lastServiceDate.present
          ? data.lastServiceDate.value
          : this.lastServiceDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceSchedule(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('intervalMileage: $intervalMileage, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('lastServiceMileage: $lastServiceMileage, ')
          ..write('lastServiceDate: $lastServiceDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    title,
    category,
    intervalMileage,
    intervalDays,
    lastServiceMileage,
    lastServiceDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceSchedule &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.title == this.title &&
          other.category == this.category &&
          other.intervalMileage == this.intervalMileage &&
          other.intervalDays == this.intervalDays &&
          other.lastServiceMileage == this.lastServiceMileage &&
          other.lastServiceDate == this.lastServiceDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MaintenanceSchedulesCompanion
    extends UpdateCompanion<MaintenanceSchedule> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> title;
  final Value<String> category;
  final Value<int?> intervalMileage;
  final Value<int?> intervalDays;
  final Value<int?> lastServiceMileage;
  final Value<DateTime?> lastServiceDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MaintenanceSchedulesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.intervalMileage = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.lastServiceMileage = const Value.absent(),
    this.lastServiceDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MaintenanceSchedulesCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String title,
    required String category,
    this.intervalMileage = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.lastServiceMileage = const Value.absent(),
    this.lastServiceDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       title = Value(title),
       category = Value(category);
  static Insertable<MaintenanceSchedule> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? title,
    Expression<String>? category,
    Expression<int>? intervalMileage,
    Expression<int>? intervalDays,
    Expression<int>? lastServiceMileage,
    Expression<DateTime>? lastServiceDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (intervalMileage != null) 'interval_mileage': intervalMileage,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (lastServiceMileage != null)
        'last_service_mileage': lastServiceMileage,
      if (lastServiceDate != null) 'last_service_date': lastServiceDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MaintenanceSchedulesCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? title,
    Value<String>? category,
    Value<int?>? intervalMileage,
    Value<int?>? intervalDays,
    Value<int?>? lastServiceMileage,
    Value<DateTime?>? lastServiceDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MaintenanceSchedulesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      title: title ?? this.title,
      category: category ?? this.category,
      intervalMileage: intervalMileage ?? this.intervalMileage,
      intervalDays: intervalDays ?? this.intervalDays,
      lastServiceMileage: lastServiceMileage ?? this.lastServiceMileage,
      lastServiceDate: lastServiceDate ?? this.lastServiceDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (intervalMileage.present) {
      map['interval_mileage'] = Variable<int>(intervalMileage.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (lastServiceMileage.present) {
      map['last_service_mileage'] = Variable<int>(lastServiceMileage.value);
    }
    if (lastServiceDate.present) {
      map['last_service_date'] = Variable<DateTime>(lastServiceDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('intervalMileage: $intervalMileage, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('lastServiceMileage: $lastServiceMileage, ')
          ..write('lastServiceDate: $lastServiceDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FuelRecordsTable extends FuelRecords
    with TableInfo<$FuelRecordsTable, FuelRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FuelRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mileageMeta = const VerificationMeta(
    'mileage',
  );
  @override
  late final GeneratedColumn<int> mileage = GeneratedColumn<int>(
    'mileage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fuelAmountLitersMeta = const VerificationMeta(
    'fuelAmountLiters',
  );
  @override
  late final GeneratedColumn<double> fuelAmountLiters = GeneratedColumn<double>(
    'fuel_amount_liters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<int> totalCost = GeneratedColumn<int>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricePerLiterMeta = const VerificationMeta(
    'pricePerLiter',
  );
  @override
  late final GeneratedColumn<double> pricePerLiter = GeneratedColumn<double>(
    'price_per_liter',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFullTankMeta = const VerificationMeta(
    'isFullTank',
  );
  @override
  late final GeneratedColumn<bool> isFullTank = GeneratedColumn<bool>(
    'is_full_tank',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_full_tank" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    date,
    mileage,
    fuelAmountLiters,
    totalCost,
    pricePerLiter,
    isFullTank,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fuel_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<FuelRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('mileage')) {
      context.handle(
        _mileageMeta,
        mileage.isAcceptableOrUnknown(data['mileage']!, _mileageMeta),
      );
    } else if (isInserting) {
      context.missing(_mileageMeta);
    }
    if (data.containsKey('fuel_amount_liters')) {
      context.handle(
        _fuelAmountLitersMeta,
        fuelAmountLiters.isAcceptableOrUnknown(
          data['fuel_amount_liters']!,
          _fuelAmountLitersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fuelAmountLitersMeta);
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCostMeta);
    }
    if (data.containsKey('price_per_liter')) {
      context.handle(
        _pricePerLiterMeta,
        pricePerLiter.isAcceptableOrUnknown(
          data['price_per_liter']!,
          _pricePerLiterMeta,
        ),
      );
    }
    if (data.containsKey('is_full_tank')) {
      context.handle(
        _isFullTankMeta,
        isFullTank.isAcceptableOrUnknown(
          data['is_full_tank']!,
          _isFullTankMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FuelRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FuelRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      mileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mileage'],
      )!,
      fuelAmountLiters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fuel_amount_liters'],
      )!,
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cost'],
      )!,
      pricePerLiter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_per_liter'],
      ),
      isFullTank: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_full_tank'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FuelRecordsTable createAlias(String alias) {
    return $FuelRecordsTable(attachedDatabase, alias);
  }
}

class FuelRecord extends DataClass implements Insertable<FuelRecord> {
  final int id;
  final int vehicleId;
  final DateTime date;
  final int mileage;
  final double fuelAmountLiters;
  final int totalCost;
  final double? pricePerLiter;
  final bool isFullTank;
  final String? notes;
  final DateTime createdAt;
  const FuelRecord({
    required this.id,
    required this.vehicleId,
    required this.date,
    required this.mileage,
    required this.fuelAmountLiters,
    required this.totalCost,
    this.pricePerLiter,
    required this.isFullTank,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['date'] = Variable<DateTime>(date);
    map['mileage'] = Variable<int>(mileage);
    map['fuel_amount_liters'] = Variable<double>(fuelAmountLiters);
    map['total_cost'] = Variable<int>(totalCost);
    if (!nullToAbsent || pricePerLiter != null) {
      map['price_per_liter'] = Variable<double>(pricePerLiter);
    }
    map['is_full_tank'] = Variable<bool>(isFullTank);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FuelRecordsCompanion toCompanion(bool nullToAbsent) {
    return FuelRecordsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      date: Value(date),
      mileage: Value(mileage),
      fuelAmountLiters: Value(fuelAmountLiters),
      totalCost: Value(totalCost),
      pricePerLiter: pricePerLiter == null && nullToAbsent
          ? const Value.absent()
          : Value(pricePerLiter),
      isFullTank: Value(isFullTank),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory FuelRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FuelRecord(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      date: serializer.fromJson<DateTime>(json['date']),
      mileage: serializer.fromJson<int>(json['mileage']),
      fuelAmountLiters: serializer.fromJson<double>(json['fuelAmountLiters']),
      totalCost: serializer.fromJson<int>(json['totalCost']),
      pricePerLiter: serializer.fromJson<double?>(json['pricePerLiter']),
      isFullTank: serializer.fromJson<bool>(json['isFullTank']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'date': serializer.toJson<DateTime>(date),
      'mileage': serializer.toJson<int>(mileage),
      'fuelAmountLiters': serializer.toJson<double>(fuelAmountLiters),
      'totalCost': serializer.toJson<int>(totalCost),
      'pricePerLiter': serializer.toJson<double?>(pricePerLiter),
      'isFullTank': serializer.toJson<bool>(isFullTank),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FuelRecord copyWith({
    int? id,
    int? vehicleId,
    DateTime? date,
    int? mileage,
    double? fuelAmountLiters,
    int? totalCost,
    Value<double?> pricePerLiter = const Value.absent(),
    bool? isFullTank,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => FuelRecord(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    date: date ?? this.date,
    mileage: mileage ?? this.mileage,
    fuelAmountLiters: fuelAmountLiters ?? this.fuelAmountLiters,
    totalCost: totalCost ?? this.totalCost,
    pricePerLiter: pricePerLiter.present
        ? pricePerLiter.value
        : this.pricePerLiter,
    isFullTank: isFullTank ?? this.isFullTank,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  FuelRecord copyWithCompanion(FuelRecordsCompanion data) {
    return FuelRecord(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      date: data.date.present ? data.date.value : this.date,
      mileage: data.mileage.present ? data.mileage.value : this.mileage,
      fuelAmountLiters: data.fuelAmountLiters.present
          ? data.fuelAmountLiters.value
          : this.fuelAmountLiters,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      pricePerLiter: data.pricePerLiter.present
          ? data.pricePerLiter.value
          : this.pricePerLiter,
      isFullTank: data.isFullTank.present
          ? data.isFullTank.value
          : this.isFullTank,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FuelRecord(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('date: $date, ')
          ..write('mileage: $mileage, ')
          ..write('fuelAmountLiters: $fuelAmountLiters, ')
          ..write('totalCost: $totalCost, ')
          ..write('pricePerLiter: $pricePerLiter, ')
          ..write('isFullTank: $isFullTank, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    date,
    mileage,
    fuelAmountLiters,
    totalCost,
    pricePerLiter,
    isFullTank,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FuelRecord &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.date == this.date &&
          other.mileage == this.mileage &&
          other.fuelAmountLiters == this.fuelAmountLiters &&
          other.totalCost == this.totalCost &&
          other.pricePerLiter == this.pricePerLiter &&
          other.isFullTank == this.isFullTank &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class FuelRecordsCompanion extends UpdateCompanion<FuelRecord> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<DateTime> date;
  final Value<int> mileage;
  final Value<double> fuelAmountLiters;
  final Value<int> totalCost;
  final Value<double?> pricePerLiter;
  final Value<bool> isFullTank;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const FuelRecordsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.date = const Value.absent(),
    this.mileage = const Value.absent(),
    this.fuelAmountLiters = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.pricePerLiter = const Value.absent(),
    this.isFullTank = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FuelRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required DateTime date,
    required int mileage,
    required double fuelAmountLiters,
    required int totalCost,
    this.pricePerLiter = const Value.absent(),
    this.isFullTank = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       date = Value(date),
       mileage = Value(mileage),
       fuelAmountLiters = Value(fuelAmountLiters),
       totalCost = Value(totalCost);
  static Insertable<FuelRecord> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<DateTime>? date,
    Expression<int>? mileage,
    Expression<double>? fuelAmountLiters,
    Expression<int>? totalCost,
    Expression<double>? pricePerLiter,
    Expression<bool>? isFullTank,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (date != null) 'date': date,
      if (mileage != null) 'mileage': mileage,
      if (fuelAmountLiters != null) 'fuel_amount_liters': fuelAmountLiters,
      if (totalCost != null) 'total_cost': totalCost,
      if (pricePerLiter != null) 'price_per_liter': pricePerLiter,
      if (isFullTank != null) 'is_full_tank': isFullTank,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FuelRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<DateTime>? date,
    Value<int>? mileage,
    Value<double>? fuelAmountLiters,
    Value<int>? totalCost,
    Value<double?>? pricePerLiter,
    Value<bool>? isFullTank,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return FuelRecordsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      date: date ?? this.date,
      mileage: mileage ?? this.mileage,
      fuelAmountLiters: fuelAmountLiters ?? this.fuelAmountLiters,
      totalCost: totalCost ?? this.totalCost,
      pricePerLiter: pricePerLiter ?? this.pricePerLiter,
      isFullTank: isFullTank ?? this.isFullTank,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (mileage.present) {
      map['mileage'] = Variable<int>(mileage.value);
    }
    if (fuelAmountLiters.present) {
      map['fuel_amount_liters'] = Variable<double>(fuelAmountLiters.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<int>(totalCost.value);
    }
    if (pricePerLiter.present) {
      map['price_per_liter'] = Variable<double>(pricePerLiter.value);
    }
    if (isFullTank.present) {
      map['is_full_tank'] = Variable<bool>(isFullTank.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FuelRecordsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('date: $date, ')
          ..write('mileage: $mileage, ')
          ..write('fuelAmountLiters: $fuelAmountLiters, ')
          ..write('totalCost: $totalCost, ')
          ..write('pricePerLiter: $pricePerLiter, ')
          ..write('isFullTank: $isFullTank, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ExpenseRecordsTable extends ExpenseRecords
    with TableInfo<$ExpenseRecordsTable, ExpenseRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    category,
    amount,
    date,
    description,
    photoPath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExpenseRecordsTable createAlias(String alias) {
    return $ExpenseRecordsTable(attachedDatabase, alias);
  }
}

class ExpenseRecord extends DataClass implements Insertable<ExpenseRecord> {
  final int id;
  final int vehicleId;
  final String category;
  final int amount;
  final DateTime date;
  final String? description;
  final String? photoPath;
  final DateTime createdAt;
  const ExpenseRecord({
    required this.id,
    required this.vehicleId,
    required this.category,
    required this.amount,
    required this.date,
    this.description,
    this.photoPath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<int>(amount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpenseRecordsCompanion toCompanion(bool nullToAbsent) {
    return ExpenseRecordsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      category: Value(category),
      amount: Value(amount),
      date: Value(date),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
    );
  }

  factory ExpenseRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseRecord(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<int>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String?>(json['description']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<int>(amount),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String?>(description),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ExpenseRecord copyWith({
    int? id,
    int? vehicleId,
    String? category,
    int? amount,
    DateTime? date,
    Value<String?> description = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    DateTime? createdAt,
  }) => ExpenseRecord(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    description: description.present ? description.value : this.description,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    createdAt: createdAt ?? this.createdAt,
  );
  ExpenseRecord copyWithCompanion(ExpenseRecordsCompanion data) {
    return ExpenseRecord(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      description: data.description.present
          ? data.description.value
          : this.description,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseRecord(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    category,
    amount,
    date,
    description,
    photoPath,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseRecord &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.description == this.description &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt);
}

class ExpenseRecordsCompanion extends UpdateCompanion<ExpenseRecord> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> category;
  final Value<int> amount;
  final Value<DateTime> date;
  final Value<String?> description;
  final Value<String?> photoPath;
  final Value<DateTime> createdAt;
  const ExpenseRecordsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExpenseRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String category,
    required int amount,
    required DateTime date,
    this.description = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       category = Value(category),
       amount = Value(amount),
       date = Value(date);
  static Insertable<ExpenseRecord> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? category,
    Expression<int>? amount,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<String>? photoPath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExpenseRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? category,
    Value<int>? amount,
    Value<DateTime>? date,
    Value<String?>? description,
    Value<String?>? photoPath,
    Value<DateTime>? createdAt,
  }) {
    return ExpenseRecordsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseRecordsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expirationDateMeta = const VerificationMeta(
    'expirationDate',
  );
  @override
  late final GeneratedColumn<DateTime> expirationDate =
      GeneratedColumn<DateTime>(
        'expiration_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    title,
    type,
    startDate,
    expirationDate,
    photoPath,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('expiration_date')) {
      context.handle(
        _expirationDateMeta,
        expirationDate.isAcceptableOrUnknown(
          data['expiration_date']!,
          _expirationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expirationDateMeta);
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      expirationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiration_date'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  final int id;
  final int vehicleId;
  final String title;
  final String type;
  final DateTime? startDate;
  final DateTime expirationDate;
  final String? photoPath;
  final String? notes;
  final DateTime createdAt;
  const Document({
    required this.id,
    required this.vehicleId,
    required this.title,
    required this.type,
    this.startDate,
    required this.expirationDate,
    this.photoPath,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    map['expiration_date'] = Variable<DateTime>(expirationDate);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      title: Value(title),
      type: Value(type),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      expirationDate: Value(expirationDate),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      expirationDate: serializer.fromJson<DateTime>(json['expirationDate']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'expirationDate': serializer.toJson<DateTime>(expirationDate),
      'photoPath': serializer.toJson<String?>(photoPath),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Document copyWith({
    int? id,
    int? vehicleId,
    String? title,
    String? type,
    Value<DateTime?> startDate = const Value.absent(),
    DateTime? expirationDate,
    Value<String?> photoPath = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => Document(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    title: title ?? this.title,
    type: type ?? this.type,
    startDate: startDate.present ? startDate.value : this.startDate,
    expirationDate: expirationDate ?? this.expirationDate,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      expirationDate: data.expirationDate.present
          ? data.expirationDate.value
          : this.expirationDate,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('startDate: $startDate, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    title,
    type,
    startDate,
    expirationDate,
    photoPath,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.title == this.title &&
          other.type == this.type &&
          other.startDate == this.startDate &&
          other.expirationDate == this.expirationDate &&
          other.photoPath == this.photoPath &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> title;
  final Value<String> type;
  final Value<DateTime?> startDate;
  final Value<DateTime> expirationDate;
  final Value<String?> photoPath;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.startDate = const Value.absent(),
    this.expirationDate = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String title,
    required String type,
    this.startDate = const Value.absent(),
    required DateTime expirationDate,
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       title = Value(title),
       type = Value(type),
       expirationDate = Value(expirationDate);
  static Insertable<Document> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? title,
    Expression<String>? type,
    Expression<DateTime>? startDate,
    Expression<DateTime>? expirationDate,
    Expression<String>? photoPath,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (startDate != null) 'start_date': startDate,
      if (expirationDate != null) 'expiration_date': expirationDate,
      if (photoPath != null) 'photo_path': photoPath,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DocumentsCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? title,
    Value<String>? type,
    Value<DateTime?>? startDate,
    Value<DateTime>? expirationDate,
    Value<String?>? photoPath,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      title: title ?? this.title,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      expirationDate: expirationDate ?? this.expirationDate,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (expirationDate.present) {
      map['expiration_date'] = Variable<DateTime>(expirationDate.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('startDate: $startDate, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeVehicleIdMeta = const VerificationMeta(
    'activeVehicleId',
  );
  @override
  late final GeneratedColumn<int> activeVehicleId = GeneratedColumn<int>(
    'active_vehicle_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _serviceReminderDaysBeforeMeta =
      const VerificationMeta('serviceReminderDaysBefore');
  @override
  late final GeneratedColumn<int> serviceReminderDaysBefore =
      GeneratedColumn<int>(
        'service_reminder_days_before',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(7),
      );
  static const VerificationMeta _documentReminderDaysBeforeMeta =
      const VerificationMeta('documentReminderDaysBefore');
  @override
  late final GeneratedColumn<int> documentReminderDaysBefore =
      GeneratedColumn<int>(
        'document_reminder_days_before',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(7),
      );
  static const VerificationMeta _distanceUnitMeta = const VerificationMeta(
    'distanceUnit',
  );
  @override
  late final GeneratedColumn<String> distanceUnit = GeneratedColumn<String>(
    'distance_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('km'),
  );
  static const VerificationMeta _fuelUnitMeta = const VerificationMeta(
    'fuelUnit',
  );
  @override
  late final GeneratedColumn<String> fuelUnit = GeneratedColumn<String>(
    'fuel_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('liter'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    activeVehicleId,
    themeMode,
    notificationsEnabled,
    serviceReminderDaysBefore,
    documentReminderDaysBefore,
    distanceUnit,
    fuelUnit,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('active_vehicle_id')) {
      context.handle(
        _activeVehicleIdMeta,
        activeVehicleId.isAcceptableOrUnknown(
          data['active_vehicle_id']!,
          _activeVehicleIdMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
        _notificationsEnabledMeta,
        notificationsEnabled.isAcceptableOrUnknown(
          data['notifications_enabled']!,
          _notificationsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('service_reminder_days_before')) {
      context.handle(
        _serviceReminderDaysBeforeMeta,
        serviceReminderDaysBefore.isAcceptableOrUnknown(
          data['service_reminder_days_before']!,
          _serviceReminderDaysBeforeMeta,
        ),
      );
    }
    if (data.containsKey('document_reminder_days_before')) {
      context.handle(
        _documentReminderDaysBeforeMeta,
        documentReminderDaysBefore.isAcceptableOrUnknown(
          data['document_reminder_days_before']!,
          _documentReminderDaysBeforeMeta,
        ),
      );
    }
    if (data.containsKey('distance_unit')) {
      context.handle(
        _distanceUnitMeta,
        distanceUnit.isAcceptableOrUnknown(
          data['distance_unit']!,
          _distanceUnitMeta,
        ),
      );
    }
    if (data.containsKey('fuel_unit')) {
      context.handle(
        _fuelUnitMeta,
        fuelUnit.isAcceptableOrUnknown(data['fuel_unit']!, _fuelUnitMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      activeVehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}active_vehicle_id'],
      ),
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
      serviceReminderDaysBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}service_reminder_days_before'],
      )!,
      documentReminderDaysBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}document_reminder_days_before'],
      )!,
      distanceUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}distance_unit'],
      )!,
      fuelUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_unit'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final int? activeVehicleId;
  final String themeMode;
  final bool notificationsEnabled;
  final int serviceReminderDaysBefore;
  final int documentReminderDaysBefore;
  final String distanceUnit;
  final String fuelUnit;
  final DateTime updatedAt;
  const AppSetting({
    required this.id,
    this.activeVehicleId,
    required this.themeMode,
    required this.notificationsEnabled,
    required this.serviceReminderDaysBefore,
    required this.documentReminderDaysBefore,
    required this.distanceUnit,
    required this.fuelUnit,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || activeVehicleId != null) {
      map['active_vehicle_id'] = Variable<int>(activeVehicleId);
    }
    map['theme_mode'] = Variable<String>(themeMode);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['service_reminder_days_before'] = Variable<int>(
      serviceReminderDaysBefore,
    );
    map['document_reminder_days_before'] = Variable<int>(
      documentReminderDaysBefore,
    );
    map['distance_unit'] = Variable<String>(distanceUnit);
    map['fuel_unit'] = Variable<String>(fuelUnit);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      activeVehicleId: activeVehicleId == null && nullToAbsent
          ? const Value.absent()
          : Value(activeVehicleId),
      themeMode: Value(themeMode),
      notificationsEnabled: Value(notificationsEnabled),
      serviceReminderDaysBefore: Value(serviceReminderDaysBefore),
      documentReminderDaysBefore: Value(documentReminderDaysBefore),
      distanceUnit: Value(distanceUnit),
      fuelUnit: Value(fuelUnit),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      activeVehicleId: serializer.fromJson<int?>(json['activeVehicleId']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
      serviceReminderDaysBefore: serializer.fromJson<int>(
        json['serviceReminderDaysBefore'],
      ),
      documentReminderDaysBefore: serializer.fromJson<int>(
        json['documentReminderDaysBefore'],
      ),
      distanceUnit: serializer.fromJson<String>(json['distanceUnit']),
      fuelUnit: serializer.fromJson<String>(json['fuelUnit']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'activeVehicleId': serializer.toJson<int?>(activeVehicleId),
      'themeMode': serializer.toJson<String>(themeMode),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'serviceReminderDaysBefore': serializer.toJson<int>(
        serviceReminderDaysBefore,
      ),
      'documentReminderDaysBefore': serializer.toJson<int>(
        documentReminderDaysBefore,
      ),
      'distanceUnit': serializer.toJson<String>(distanceUnit),
      'fuelUnit': serializer.toJson<String>(fuelUnit),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({
    int? id,
    Value<int?> activeVehicleId = const Value.absent(),
    String? themeMode,
    bool? notificationsEnabled,
    int? serviceReminderDaysBefore,
    int? documentReminderDaysBefore,
    String? distanceUnit,
    String? fuelUnit,
    DateTime? updatedAt,
  }) => AppSetting(
    id: id ?? this.id,
    activeVehicleId: activeVehicleId.present
        ? activeVehicleId.value
        : this.activeVehicleId,
    themeMode: themeMode ?? this.themeMode,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    serviceReminderDaysBefore:
        serviceReminderDaysBefore ?? this.serviceReminderDaysBefore,
    documentReminderDaysBefore:
        documentReminderDaysBefore ?? this.documentReminderDaysBefore,
    distanceUnit: distanceUnit ?? this.distanceUnit,
    fuelUnit: fuelUnit ?? this.fuelUnit,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      activeVehicleId: data.activeVehicleId.present
          ? data.activeVehicleId.value
          : this.activeVehicleId,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      serviceReminderDaysBefore: data.serviceReminderDaysBefore.present
          ? data.serviceReminderDaysBefore.value
          : this.serviceReminderDaysBefore,
      documentReminderDaysBefore: data.documentReminderDaysBefore.present
          ? data.documentReminderDaysBefore.value
          : this.documentReminderDaysBefore,
      distanceUnit: data.distanceUnit.present
          ? data.distanceUnit.value
          : this.distanceUnit,
      fuelUnit: data.fuelUnit.present ? data.fuelUnit.value : this.fuelUnit,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('activeVehicleId: $activeVehicleId, ')
          ..write('themeMode: $themeMode, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('serviceReminderDaysBefore: $serviceReminderDaysBefore, ')
          ..write('documentReminderDaysBefore: $documentReminderDaysBefore, ')
          ..write('distanceUnit: $distanceUnit, ')
          ..write('fuelUnit: $fuelUnit, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    activeVehicleId,
    themeMode,
    notificationsEnabled,
    serviceReminderDaysBefore,
    documentReminderDaysBefore,
    distanceUnit,
    fuelUnit,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.activeVehicleId == this.activeVehicleId &&
          other.themeMode == this.themeMode &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.serviceReminderDaysBefore == this.serviceReminderDaysBefore &&
          other.documentReminderDaysBefore == this.documentReminderDaysBefore &&
          other.distanceUnit == this.distanceUnit &&
          other.fuelUnit == this.fuelUnit &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<int?> activeVehicleId;
  final Value<String> themeMode;
  final Value<bool> notificationsEnabled;
  final Value<int> serviceReminderDaysBefore;
  final Value<int> documentReminderDaysBefore;
  final Value<String> distanceUnit;
  final Value<String> fuelUnit;
  final Value<DateTime> updatedAt;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.activeVehicleId = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.serviceReminderDaysBefore = const Value.absent(),
    this.documentReminderDaysBefore = const Value.absent(),
    this.distanceUnit = const Value.absent(),
    this.fuelUnit = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.activeVehicleId = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.serviceReminderDaysBefore = const Value.absent(),
    this.documentReminderDaysBefore = const Value.absent(),
    this.distanceUnit = const Value.absent(),
    this.fuelUnit = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<int>? activeVehicleId,
    Expression<String>? themeMode,
    Expression<bool>? notificationsEnabled,
    Expression<int>? serviceReminderDaysBefore,
    Expression<int>? documentReminderDaysBefore,
    Expression<String>? distanceUnit,
    Expression<String>? fuelUnit,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activeVehicleId != null) 'active_vehicle_id': activeVehicleId,
      if (themeMode != null) 'theme_mode': themeMode,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (serviceReminderDaysBefore != null)
        'service_reminder_days_before': serviceReminderDaysBefore,
      if (documentReminderDaysBefore != null)
        'document_reminder_days_before': documentReminderDaysBefore,
      if (distanceUnit != null) 'distance_unit': distanceUnit,
      if (fuelUnit != null) 'fuel_unit': fuelUnit,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<int?>? activeVehicleId,
    Value<String>? themeMode,
    Value<bool>? notificationsEnabled,
    Value<int>? serviceReminderDaysBefore,
    Value<int>? documentReminderDaysBefore,
    Value<String>? distanceUnit,
    Value<String>? fuelUnit,
    Value<DateTime>? updatedAt,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      activeVehicleId: activeVehicleId ?? this.activeVehicleId,
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      serviceReminderDaysBefore:
          serviceReminderDaysBefore ?? this.serviceReminderDaysBefore,
      documentReminderDaysBefore:
          documentReminderDaysBefore ?? this.documentReminderDaysBefore,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      fuelUnit: fuelUnit ?? this.fuelUnit,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (activeVehicleId.present) {
      map['active_vehicle_id'] = Variable<int>(activeVehicleId.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (serviceReminderDaysBefore.present) {
      map['service_reminder_days_before'] = Variable<int>(
        serviceReminderDaysBefore.value,
      );
    }
    if (documentReminderDaysBefore.present) {
      map['document_reminder_days_before'] = Variable<int>(
        documentReminderDaysBefore.value,
      );
    }
    if (distanceUnit.present) {
      map['distance_unit'] = Variable<String>(distanceUnit.value);
    }
    if (fuelUnit.present) {
      map['fuel_unit'] = Variable<String>(fuelUnit.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('activeVehicleId: $activeVehicleId, ')
          ..write('themeMode: $themeMode, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('serviceReminderDaysBefore: $serviceReminderDaysBefore, ')
          ..write('documentReminderDaysBefore: $documentReminderDaysBefore, ')
          ..write('distanceUnit: $distanceUnit, ')
          ..write('fuelUnit: $fuelUnit, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ParkingSpotsTable extends ParkingSpots
    with TableInfo<$ParkingSpotsTable, ParkingSpot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParkingSpotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    latitude,
    longitude,
    note,
    photoPath,
    savedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parking_spots';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParkingSpot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParkingSpot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParkingSpot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $ParkingSpotsTable createAlias(String alias) {
    return $ParkingSpotsTable(attachedDatabase, alias);
  }
}

class ParkingSpot extends DataClass implements Insertable<ParkingSpot> {
  final int id;
  final int vehicleId;
  final double? latitude;
  final double? longitude;
  final String? note;
  final String? photoPath;
  final DateTime savedAt;
  const ParkingSpot({
    required this.id,
    required this.vehicleId,
    this.latitude,
    this.longitude,
    this.note,
    this.photoPath,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  ParkingSpotsCompanion toCompanion(bool nullToAbsent) {
    return ParkingSpotsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      savedAt: Value(savedAt),
    );
  }

  factory ParkingSpot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParkingSpot(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      note: serializer.fromJson<String?>(json['note']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'note': serializer.toJson<String?>(note),
      'photoPath': serializer.toJson<String?>(photoPath),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  ParkingSpot copyWith({
    int? id,
    int? vehicleId,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    DateTime? savedAt,
  }) => ParkingSpot(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    note: note.present ? note.value : this.note,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    savedAt: savedAt ?? this.savedAt,
  );
  ParkingSpot copyWithCompanion(ParkingSpotsCompanion data) {
    return ParkingSpot(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      note: data.note.present ? data.note.value : this.note,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParkingSpot(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('note: $note, ')
          ..write('photoPath: $photoPath, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, vehicleId, latitude, longitude, note, photoPath, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParkingSpot &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.note == this.note &&
          other.photoPath == this.photoPath &&
          other.savedAt == this.savedAt);
}

class ParkingSpotsCompanion extends UpdateCompanion<ParkingSpot> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> note;
  final Value<String?> photoPath;
  final Value<DateTime> savedAt;
  const ParkingSpotsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.note = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  ParkingSpotsCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.note = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.savedAt = const Value.absent(),
  }) : vehicleId = Value(vehicleId);
  static Insertable<ParkingSpot> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? note,
    Expression<String>? photoPath,
    Expression<DateTime>? savedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (note != null) 'note': note,
      if (photoPath != null) 'photo_path': photoPath,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  ParkingSpotsCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? note,
    Value<String?>? photoPath,
    Value<DateTime>? savedAt,
  }) {
    return ParkingSpotsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      note: note ?? this.note,
      photoPath: photoPath ?? this.photoPath,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParkingSpotsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('note: $note, ')
          ..write('photoPath: $photoPath, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $MaintenanceRecordsTable maintenanceRecords =
      $MaintenanceRecordsTable(this);
  late final $MaintenanceSchedulesTable maintenanceSchedules =
      $MaintenanceSchedulesTable(this);
  late final $FuelRecordsTable fuelRecords = $FuelRecordsTable(this);
  late final $ExpenseRecordsTable expenseRecords = $ExpenseRecordsTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $ParkingSpotsTable parkingSpots = $ParkingSpotsTable(this);
  late final Index idxMaintenanceRecordsVehicle = Index(
    'idx_maintenance_records_vehicle',
    'CREATE INDEX idx_maintenance_records_vehicle ON maintenance_records (vehicle_id)',
  );
  late final Index idxMaintenanceSchedulesVehicleCategory = Index(
    'idx_maintenance_schedules_vehicle_category',
    'CREATE INDEX idx_maintenance_schedules_vehicle_category ON maintenance_schedules (vehicle_id, category)',
  );
  late final Index idxFuelRecordsVehicle = Index(
    'idx_fuel_records_vehicle',
    'CREATE INDEX idx_fuel_records_vehicle ON fuel_records (vehicle_id)',
  );
  late final Index idxExpenseRecordsVehicle = Index(
    'idx_expense_records_vehicle',
    'CREATE INDEX idx_expense_records_vehicle ON expense_records (vehicle_id)',
  );
  late final Index idxDocumentsVehicle = Index(
    'idx_documents_vehicle',
    'CREATE INDEX idx_documents_vehicle ON documents (vehicle_id)',
  );
  late final Index idxParkingSpotsVehicle = Index(
    'idx_parking_spots_vehicle',
    'CREATE INDEX idx_parking_spots_vehicle ON parking_spots (vehicle_id)',
  );
  late final VehicleDao vehicleDao = VehicleDao(this as AppDatabase);
  late final MaintenanceRecordDao maintenanceRecordDao = MaintenanceRecordDao(
    this as AppDatabase,
  );
  late final MaintenanceScheduleDao maintenanceScheduleDao =
      MaintenanceScheduleDao(this as AppDatabase);
  late final FuelRecordDao fuelRecordDao = FuelRecordDao(this as AppDatabase);
  late final ExpenseRecordDao expenseRecordDao = ExpenseRecordDao(
    this as AppDatabase,
  );
  late final DocumentDao documentDao = DocumentDao(this as AppDatabase);
  late final AppSettingsDao appSettingsDao = AppSettingsDao(
    this as AppDatabase,
  );
  late final ParkingSpotDao parkingSpotDao = ParkingSpotDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    vehicles,
    maintenanceRecords,
    maintenanceSchedules,
    fuelRecords,
    expenseRecords,
    documents,
    appSettings,
    parkingSpots,
    idxMaintenanceRecordsVehicle,
    idxMaintenanceSchedulesVehicleCategory,
    idxFuelRecordsVehicle,
    idxExpenseRecordsVehicle,
    idxDocumentsVehicle,
    idxParkingSpotsVehicle,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('maintenance_records', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('maintenance_schedules', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fuel_records', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('expense_records', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('documents', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('app_settings', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('parking_spots', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$VehiclesTableCreateCompanionBuilder =
    VehiclesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> brand,
      Value<String?> model,
      Value<int?> modelYear,
      Value<String?> color,
      Value<String?> licensePlate,
      Value<int> currentMileage,
      Value<String?> photoPath,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> oilType,
      Value<String?> oilFilterModel,
      Value<String?> airFilterModel,
      Value<String?> cabinFilterModel,
      Value<String?> tireSize,
      Value<String?> batteryModel,
      Value<String?> sparkPlugModel,
    });
typedef $$VehiclesTableUpdateCompanionBuilder =
    VehiclesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> brand,
      Value<String?> model,
      Value<int?> modelYear,
      Value<String?> color,
      Value<String?> licensePlate,
      Value<int> currentMileage,
      Value<String?> photoPath,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> oilType,
      Value<String?> oilFilterModel,
      Value<String?> airFilterModel,
      Value<String?> cabinFilterModel,
      Value<String?> tireSize,
      Value<String?> batteryModel,
      Value<String?> sparkPlugModel,
    });

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MaintenanceRecordsTable, List<MaintenanceRecord>>
  _maintenanceRecordsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.maintenanceRecords,
        aliasName: 'vehicles__id__maintenance_records__vehicle_id',
      );

  $$MaintenanceRecordsTableProcessedTableManager get maintenanceRecordsRefs {
    final manager = $$MaintenanceRecordsTableTableManager(
      $_db,
      $_db.maintenanceRecords,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _maintenanceRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MaintenanceSchedulesTable,
    List<MaintenanceSchedule>
  >
  _maintenanceSchedulesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.maintenanceSchedules,
        aliasName: 'vehicles__id__maintenance_schedules__vehicle_id',
      );

  $$MaintenanceSchedulesTableProcessedTableManager
  get maintenanceSchedulesRefs {
    final manager = $$MaintenanceSchedulesTableTableManager(
      $_db,
      $_db.maintenanceSchedules,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _maintenanceSchedulesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FuelRecordsTable, List<FuelRecord>>
  _fuelRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fuelRecords,
    aliasName: 'vehicles__id__fuel_records__vehicle_id',
  );

  $$FuelRecordsTableProcessedTableManager get fuelRecordsRefs {
    final manager = $$FuelRecordsTableTableManager(
      $_db,
      $_db.fuelRecords,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fuelRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpenseRecordsTable, List<ExpenseRecord>>
  _expenseRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expenseRecords,
    aliasName: 'vehicles__id__expense_records__vehicle_id',
  );

  $$ExpenseRecordsTableProcessedTableManager get expenseRecordsRefs {
    final manager = $$ExpenseRecordsTableTableManager(
      $_db,
      $_db.expenseRecords,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expenseRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumentsTable, List<Document>>
  _documentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: 'vehicles__id__documents__vehicle_id',
  );

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AppSettingsTable, List<AppSetting>>
  _appSettingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.appSettings,
    aliasName: 'vehicles__id__app_settings__active_vehicle_id',
  );

  $$AppSettingsTableProcessedTableManager get appSettingsRefs {
    final manager = $$AppSettingsTableTableManager(
      $_db,
      $_db.appSettings,
    ).filter((f) => f.activeVehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_appSettingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ParkingSpotsTable, List<ParkingSpot>>
  _parkingSpotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.parkingSpots,
    aliasName: 'vehicles__id__parking_spots__vehicle_id',
  );

  $$ParkingSpotsTableProcessedTableManager get parkingSpotsRefs {
    final manager = $$ParkingSpotsTableTableManager(
      $_db,
      $_db.parkingSpots,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_parkingSpotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get modelYear => $composableBuilder(
    column: $table.modelYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentMileage => $composableBuilder(
    column: $table.currentMileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get oilType => $composableBuilder(
    column: $table.oilType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get oilFilterModel => $composableBuilder(
    column: $table.oilFilterModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get airFilterModel => $composableBuilder(
    column: $table.airFilterModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cabinFilterModel => $composableBuilder(
    column: $table.cabinFilterModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tireSize => $composableBuilder(
    column: $table.tireSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batteryModel => $composableBuilder(
    column: $table.batteryModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sparkPlugModel => $composableBuilder(
    column: $table.sparkPlugModel,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> maintenanceRecordsRefs(
    Expression<bool> Function($$MaintenanceRecordsTableFilterComposer f) f,
  ) {
    final $$MaintenanceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceRecords,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> maintenanceSchedulesRefs(
    Expression<bool> Function($$MaintenanceSchedulesTableFilterComposer f) f,
  ) {
    final $$MaintenanceSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceSchedules,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fuelRecordsRefs(
    Expression<bool> Function($$FuelRecordsTableFilterComposer f) f,
  ) {
    final $$FuelRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelRecords,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelRecordsTableFilterComposer(
            $db: $db,
            $table: $db.fuelRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expenseRecordsRefs(
    Expression<bool> Function($$ExpenseRecordsTableFilterComposer f) f,
  ) {
    final $$ExpenseRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenseRecords,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseRecordsTableFilterComposer(
            $db: $db,
            $table: $db.expenseRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentsRefs(
    Expression<bool> Function($$DocumentsTableFilterComposer f) f,
  ) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> appSettingsRefs(
    Expression<bool> Function($$AppSettingsTableFilterComposer f) f,
  ) {
    final $$AppSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appSettings,
      getReferencedColumn: (t) => t.activeVehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppSettingsTableFilterComposer(
            $db: $db,
            $table: $db.appSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> parkingSpotsRefs(
    Expression<bool> Function($$ParkingSpotsTableFilterComposer f) f,
  ) {
    final $$ParkingSpotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parkingSpots,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParkingSpotsTableFilterComposer(
            $db: $db,
            $table: $db.parkingSpots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get modelYear => $composableBuilder(
    column: $table.modelYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentMileage => $composableBuilder(
    column: $table.currentMileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get oilType => $composableBuilder(
    column: $table.oilType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get oilFilterModel => $composableBuilder(
    column: $table.oilFilterModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get airFilterModel => $composableBuilder(
    column: $table.airFilterModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cabinFilterModel => $composableBuilder(
    column: $table.cabinFilterModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tireSize => $composableBuilder(
    column: $table.tireSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batteryModel => $composableBuilder(
    column: $table.batteryModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sparkPlugModel => $composableBuilder(
    column: $table.sparkPlugModel,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get modelYear =>
      $composableBuilder(column: $table.modelYear, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentMileage => $composableBuilder(
    column: $table.currentMileage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get oilType =>
      $composableBuilder(column: $table.oilType, builder: (column) => column);

  GeneratedColumn<String> get oilFilterModel => $composableBuilder(
    column: $table.oilFilterModel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get airFilterModel => $composableBuilder(
    column: $table.airFilterModel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cabinFilterModel => $composableBuilder(
    column: $table.cabinFilterModel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tireSize =>
      $composableBuilder(column: $table.tireSize, builder: (column) => column);

  GeneratedColumn<String> get batteryModel => $composableBuilder(
    column: $table.batteryModel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sparkPlugModel => $composableBuilder(
    column: $table.sparkPlugModel,
    builder: (column) => column,
  );

  Expression<T> maintenanceRecordsRefs<T extends Object>(
    Expression<T> Function($$MaintenanceRecordsTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.maintenanceRecords,
          getReferencedColumn: (t) => t.vehicleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.maintenanceRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> maintenanceSchedulesRefs<T extends Object>(
    Expression<T> Function($$MaintenanceSchedulesTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceSchedulesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.maintenanceSchedules,
          getReferencedColumn: (t) => t.vehicleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceSchedulesTableAnnotationComposer(
                $db: $db,
                $table: $db.maintenanceSchedules,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> fuelRecordsRefs<T extends Object>(
    Expression<T> Function($$FuelRecordsTableAnnotationComposer a) f,
  ) {
    final $$FuelRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelRecords,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expenseRecordsRefs<T extends Object>(
    Expression<T> Function($$ExpenseRecordsTableAnnotationComposer a) f,
  ) {
    final $$ExpenseRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenseRecords,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.expenseRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($$DocumentsTableAnnotationComposer a) f,
  ) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> appSettingsRefs<T extends Object>(
    Expression<T> Function($$AppSettingsTableAnnotationComposer a) f,
  ) {
    final $$AppSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appSettings,
      getReferencedColumn: (t) => t.activeVehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.appSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> parkingSpotsRefs<T extends Object>(
    Expression<T> Function($$ParkingSpotsTableAnnotationComposer a) f,
  ) {
    final $$ParkingSpotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parkingSpots,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParkingSpotsTableAnnotationComposer(
            $db: $db,
            $table: $db.parkingSpots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiclesTable,
          Vehicle,
          $$VehiclesTableFilterComposer,
          $$VehiclesTableOrderingComposer,
          $$VehiclesTableAnnotationComposer,
          $$VehiclesTableCreateCompanionBuilder,
          $$VehiclesTableUpdateCompanionBuilder,
          (Vehicle, $$VehiclesTableReferences),
          Vehicle,
          PrefetchHooks Function({
            bool maintenanceRecordsRefs,
            bool maintenanceSchedulesRefs,
            bool fuelRecordsRefs,
            bool expenseRecordsRefs,
            bool documentsRefs,
            bool appSettingsRefs,
            bool parkingSpotsRefs,
          })
        > {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<int?> modelYear = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> licensePlate = const Value.absent(),
                Value<int> currentMileage = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> oilType = const Value.absent(),
                Value<String?> oilFilterModel = const Value.absent(),
                Value<String?> airFilterModel = const Value.absent(),
                Value<String?> cabinFilterModel = const Value.absent(),
                Value<String?> tireSize = const Value.absent(),
                Value<String?> batteryModel = const Value.absent(),
                Value<String?> sparkPlugModel = const Value.absent(),
              }) => VehiclesCompanion(
                id: id,
                name: name,
                brand: brand,
                model: model,
                modelYear: modelYear,
                color: color,
                licensePlate: licensePlate,
                currentMileage: currentMileage,
                photoPath: photoPath,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                oilType: oilType,
                oilFilterModel: oilFilterModel,
                airFilterModel: airFilterModel,
                cabinFilterModel: cabinFilterModel,
                tireSize: tireSize,
                batteryModel: batteryModel,
                sparkPlugModel: sparkPlugModel,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> brand = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<int?> modelYear = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> licensePlate = const Value.absent(),
                Value<int> currentMileage = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> oilType = const Value.absent(),
                Value<String?> oilFilterModel = const Value.absent(),
                Value<String?> airFilterModel = const Value.absent(),
                Value<String?> cabinFilterModel = const Value.absent(),
                Value<String?> tireSize = const Value.absent(),
                Value<String?> batteryModel = const Value.absent(),
                Value<String?> sparkPlugModel = const Value.absent(),
              }) => VehiclesCompanion.insert(
                id: id,
                name: name,
                brand: brand,
                model: model,
                modelYear: modelYear,
                color: color,
                licensePlate: licensePlate,
                currentMileage: currentMileage,
                photoPath: photoPath,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                oilType: oilType,
                oilFilterModel: oilFilterModel,
                airFilterModel: airFilterModel,
                cabinFilterModel: cabinFilterModel,
                tireSize: tireSize,
                batteryModel: batteryModel,
                sparkPlugModel: sparkPlugModel,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehiclesTable, Vehicle>(table),
                  $$VehiclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                maintenanceRecordsRefs = false,
                maintenanceSchedulesRefs = false,
                fuelRecordsRefs = false,
                expenseRecordsRefs = false,
                documentsRefs = false,
                appSettingsRefs = false,
                parkingSpotsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (maintenanceRecordsRefs) db.maintenanceRecords,
                    if (maintenanceSchedulesRefs) db.maintenanceSchedules,
                    if (fuelRecordsRefs) db.fuelRecords,
                    if (expenseRecordsRefs) db.expenseRecords,
                    if (documentsRefs) db.documents,
                    if (appSettingsRefs) db.appSettings,
                    if (parkingSpotsRefs) db.parkingSpots,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (maintenanceRecordsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          MaintenanceRecord
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._maintenanceRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenanceRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (maintenanceSchedulesRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          MaintenanceSchedule
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._maintenanceSchedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenanceSchedulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fuelRecordsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          FuelRecord
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._fuelRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).fuelRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expenseRecordsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          ExpenseRecord
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._expenseRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).expenseRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documentsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          Document
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._documentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).documentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (appSettingsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          AppSetting
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._appSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).appSettingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.activeVehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (parkingSpotsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          ParkingSpot
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._parkingSpotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).parkingSpotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VehiclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiclesTable,
      Vehicle,
      $$VehiclesTableFilterComposer,
      $$VehiclesTableOrderingComposer,
      $$VehiclesTableAnnotationComposer,
      $$VehiclesTableCreateCompanionBuilder,
      $$VehiclesTableUpdateCompanionBuilder,
      (Vehicle, $$VehiclesTableReferences),
      Vehicle,
      PrefetchHooks Function({
        bool maintenanceRecordsRefs,
        bool maintenanceSchedulesRefs,
        bool fuelRecordsRefs,
        bool expenseRecordsRefs,
        bool documentsRefs,
        bool appSettingsRefs,
        bool parkingSpotsRefs,
      })
    >;
typedef $$MaintenanceRecordsTableCreateCompanionBuilder =
    MaintenanceRecordsCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String title,
      required String category,
      required DateTime date,
      required int mileage,
      Value<int> cost,
      Value<String?> description,
      Value<String?> photoPath,
      Value<int?> nextServiceMileage,
      Value<DateTime?> nextServiceDate,
      Value<DateTime> createdAt,
    });
typedef $$MaintenanceRecordsTableUpdateCompanionBuilder =
    MaintenanceRecordsCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> title,
      Value<String> category,
      Value<DateTime> date,
      Value<int> mileage,
      Value<int> cost,
      Value<String?> description,
      Value<String?> photoPath,
      Value<int?> nextServiceMileage,
      Value<DateTime?> nextServiceDate,
      Value<DateTime> createdAt,
    });

final class $$MaintenanceRecordsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MaintenanceRecordsTable,
          MaintenanceRecord
        > {
  $$MaintenanceRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('maintenance_records__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MaintenanceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextServiceMileage => $composableBuilder(
    column: $table.nextServiceMileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextServiceMileage => $composableBuilder(
    column: $table.nextServiceMileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get mileage =>
      $composableBuilder(column: $table.mileage, builder: (column) => column);

  GeneratedColumn<int> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<int> get nextServiceMileage => $composableBuilder(
    column: $table.nextServiceMileage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceRecordsTable,
          MaintenanceRecord,
          $$MaintenanceRecordsTableFilterComposer,
          $$MaintenanceRecordsTableOrderingComposer,
          $$MaintenanceRecordsTableAnnotationComposer,
          $$MaintenanceRecordsTableCreateCompanionBuilder,
          $$MaintenanceRecordsTableUpdateCompanionBuilder,
          (MaintenanceRecord, $$MaintenanceRecordsTableReferences),
          MaintenanceRecord,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$MaintenanceRecordsTableTableManager(
    _$AppDatabase db,
    $MaintenanceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> mileage = const Value.absent(),
                Value<int> cost = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<int?> nextServiceMileage = const Value.absent(),
                Value<DateTime?> nextServiceDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MaintenanceRecordsCompanion(
                id: id,
                vehicleId: vehicleId,
                title: title,
                category: category,
                date: date,
                mileage: mileage,
                cost: cost,
                description: description,
                photoPath: photoPath,
                nextServiceMileage: nextServiceMileage,
                nextServiceDate: nextServiceDate,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String title,
                required String category,
                required DateTime date,
                required int mileage,
                Value<int> cost = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<int?> nextServiceMileage = const Value.absent(),
                Value<DateTime?> nextServiceDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MaintenanceRecordsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                title: title,
                category: category,
                date: date,
                mileage: mileage,
                cost: cost,
                description: description,
                photoPath: photoPath,
                nextServiceMileage: nextServiceMileage,
                nextServiceDate: nextServiceDate,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MaintenanceRecordsTable, MaintenanceRecord>(
                    table,
                  ),
                  $$MaintenanceRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable:
                                    $$MaintenanceRecordsTableReferences
                                        ._vehicleIdTable(db),
                                referencedColumn:
                                    $$MaintenanceRecordsTableReferences
                                        ._vehicleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MaintenanceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceRecordsTable,
      MaintenanceRecord,
      $$MaintenanceRecordsTableFilterComposer,
      $$MaintenanceRecordsTableOrderingComposer,
      $$MaintenanceRecordsTableAnnotationComposer,
      $$MaintenanceRecordsTableCreateCompanionBuilder,
      $$MaintenanceRecordsTableUpdateCompanionBuilder,
      (MaintenanceRecord, $$MaintenanceRecordsTableReferences),
      MaintenanceRecord,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$MaintenanceSchedulesTableCreateCompanionBuilder =
    MaintenanceSchedulesCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String title,
      required String category,
      Value<int?> intervalMileage,
      Value<int?> intervalDays,
      Value<int?> lastServiceMileage,
      Value<DateTime?> lastServiceDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$MaintenanceSchedulesTableUpdateCompanionBuilder =
    MaintenanceSchedulesCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> title,
      Value<String> category,
      Value<int?> intervalMileage,
      Value<int?> intervalDays,
      Value<int?> lastServiceMileage,
      Value<DateTime?> lastServiceDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$MaintenanceSchedulesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MaintenanceSchedulesTable,
          MaintenanceSchedule
        > {
  $$MaintenanceSchedulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) => db.vehicles
      .createAlias('maintenance_schedules__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MaintenanceSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceSchedulesTable> {
  $$MaintenanceSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalMileage => $composableBuilder(
    column: $table.intervalMileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastServiceMileage => $composableBuilder(
    column: $table.lastServiceMileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastServiceDate => $composableBuilder(
    column: $table.lastServiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceSchedulesTable> {
  $$MaintenanceSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalMileage => $composableBuilder(
    column: $table.intervalMileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastServiceMileage => $composableBuilder(
    column: $table.lastServiceMileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastServiceDate => $composableBuilder(
    column: $table.lastServiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceSchedulesTable> {
  $$MaintenanceSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get intervalMileage => $composableBuilder(
    column: $table.intervalMileage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastServiceMileage => $composableBuilder(
    column: $table.lastServiceMileage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastServiceDate => $composableBuilder(
    column: $table.lastServiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceSchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceSchedulesTable,
          MaintenanceSchedule,
          $$MaintenanceSchedulesTableFilterComposer,
          $$MaintenanceSchedulesTableOrderingComposer,
          $$MaintenanceSchedulesTableAnnotationComposer,
          $$MaintenanceSchedulesTableCreateCompanionBuilder,
          $$MaintenanceSchedulesTableUpdateCompanionBuilder,
          (MaintenanceSchedule, $$MaintenanceSchedulesTableReferences),
          MaintenanceSchedule,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$MaintenanceSchedulesTableTableManager(
    _$AppDatabase db,
    $MaintenanceSchedulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceSchedulesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MaintenanceSchedulesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int?> intervalMileage = const Value.absent(),
                Value<int?> intervalDays = const Value.absent(),
                Value<int?> lastServiceMileage = const Value.absent(),
                Value<DateTime?> lastServiceDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MaintenanceSchedulesCompanion(
                id: id,
                vehicleId: vehicleId,
                title: title,
                category: category,
                intervalMileage: intervalMileage,
                intervalDays: intervalDays,
                lastServiceMileage: lastServiceMileage,
                lastServiceDate: lastServiceDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String title,
                required String category,
                Value<int?> intervalMileage = const Value.absent(),
                Value<int?> intervalDays = const Value.absent(),
                Value<int?> lastServiceMileage = const Value.absent(),
                Value<DateTime?> lastServiceDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MaintenanceSchedulesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                title: title,
                category: category,
                intervalMileage: intervalMileage,
                intervalDays: intervalDays,
                lastServiceMileage: lastServiceMileage,
                lastServiceDate: lastServiceDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MaintenanceSchedulesTable, MaintenanceSchedule>(
                    table,
                  ),
                  $$MaintenanceSchedulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable:
                                    $$MaintenanceSchedulesTableReferences
                                        ._vehicleIdTable(db),
                                referencedColumn:
                                    $$MaintenanceSchedulesTableReferences
                                        ._vehicleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MaintenanceSchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceSchedulesTable,
      MaintenanceSchedule,
      $$MaintenanceSchedulesTableFilterComposer,
      $$MaintenanceSchedulesTableOrderingComposer,
      $$MaintenanceSchedulesTableAnnotationComposer,
      $$MaintenanceSchedulesTableCreateCompanionBuilder,
      $$MaintenanceSchedulesTableUpdateCompanionBuilder,
      (MaintenanceSchedule, $$MaintenanceSchedulesTableReferences),
      MaintenanceSchedule,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$FuelRecordsTableCreateCompanionBuilder =
    FuelRecordsCompanion Function({
      Value<int> id,
      required int vehicleId,
      required DateTime date,
      required int mileage,
      required double fuelAmountLiters,
      required int totalCost,
      Value<double?> pricePerLiter,
      Value<bool> isFullTank,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$FuelRecordsTableUpdateCompanionBuilder =
    FuelRecordsCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<DateTime> date,
      Value<int> mileage,
      Value<double> fuelAmountLiters,
      Value<int> totalCost,
      Value<double?> pricePerLiter,
      Value<bool> isFullTank,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

final class $$FuelRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $FuelRecordsTable, FuelRecord> {
  $$FuelRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('fuel_records__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FuelRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $FuelRecordsTable> {
  $$FuelRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fuelAmountLiters => $composableBuilder(
    column: $table.fuelAmountLiters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $FuelRecordsTable> {
  $$FuelRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fuelAmountLiters => $composableBuilder(
    column: $table.fuelAmountLiters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FuelRecordsTable> {
  $$FuelRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get mileage =>
      $composableBuilder(column: $table.mileage, builder: (column) => column);

  GeneratedColumn<double> get fuelAmountLiters => $composableBuilder(
    column: $table.fuelAmountLiters,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FuelRecordsTable,
          FuelRecord,
          $$FuelRecordsTableFilterComposer,
          $$FuelRecordsTableOrderingComposer,
          $$FuelRecordsTableAnnotationComposer,
          $$FuelRecordsTableCreateCompanionBuilder,
          $$FuelRecordsTableUpdateCompanionBuilder,
          (FuelRecord, $$FuelRecordsTableReferences),
          FuelRecord,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$FuelRecordsTableTableManager(_$AppDatabase db, $FuelRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FuelRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FuelRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FuelRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> mileage = const Value.absent(),
                Value<double> fuelAmountLiters = const Value.absent(),
                Value<int> totalCost = const Value.absent(),
                Value<double?> pricePerLiter = const Value.absent(),
                Value<bool> isFullTank = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FuelRecordsCompanion(
                id: id,
                vehicleId: vehicleId,
                date: date,
                mileage: mileage,
                fuelAmountLiters: fuelAmountLiters,
                totalCost: totalCost,
                pricePerLiter: pricePerLiter,
                isFullTank: isFullTank,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required DateTime date,
                required int mileage,
                required double fuelAmountLiters,
                required int totalCost,
                Value<double?> pricePerLiter = const Value.absent(),
                Value<bool> isFullTank = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FuelRecordsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                date: date,
                mileage: mileage,
                fuelAmountLiters: fuelAmountLiters,
                totalCost: totalCost,
                pricePerLiter: pricePerLiter,
                isFullTank: isFullTank,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FuelRecordsTable, FuelRecord>(table),
                  $$FuelRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$FuelRecordsTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$FuelRecordsTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FuelRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FuelRecordsTable,
      FuelRecord,
      $$FuelRecordsTableFilterComposer,
      $$FuelRecordsTableOrderingComposer,
      $$FuelRecordsTableAnnotationComposer,
      $$FuelRecordsTableCreateCompanionBuilder,
      $$FuelRecordsTableUpdateCompanionBuilder,
      (FuelRecord, $$FuelRecordsTableReferences),
      FuelRecord,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$ExpenseRecordsTableCreateCompanionBuilder =
    ExpenseRecordsCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String category,
      required int amount,
      required DateTime date,
      Value<String?> description,
      Value<String?> photoPath,
      Value<DateTime> createdAt,
    });
typedef $$ExpenseRecordsTableUpdateCompanionBuilder =
    ExpenseRecordsCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> category,
      Value<int> amount,
      Value<DateTime> date,
      Value<String?> description,
      Value<String?> photoPath,
      Value<DateTime> createdAt,
    });

final class $$ExpenseRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $ExpenseRecordsTable, ExpenseRecord> {
  $$ExpenseRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('expense_records__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpenseRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ExpenseRecordsTable> {
  $$ExpenseRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpenseRecordsTable> {
  $$ExpenseRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpenseRecordsTable> {
  $$ExpenseRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpenseRecordsTable,
          ExpenseRecord,
          $$ExpenseRecordsTableFilterComposer,
          $$ExpenseRecordsTableOrderingComposer,
          $$ExpenseRecordsTableAnnotationComposer,
          $$ExpenseRecordsTableCreateCompanionBuilder,
          $$ExpenseRecordsTableUpdateCompanionBuilder,
          (ExpenseRecord, $$ExpenseRecordsTableReferences),
          ExpenseRecord,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$ExpenseRecordsTableTableManager(
    _$AppDatabase db,
    $ExpenseRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpenseRecordsCompanion(
                id: id,
                vehicleId: vehicleId,
                category: category,
                amount: amount,
                date: date,
                description: description,
                photoPath: photoPath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String category,
                required int amount,
                required DateTime date,
                Value<String?> description = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpenseRecordsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                category: category,
                amount: amount,
                date: date,
                description: description,
                photoPath: photoPath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExpenseRecordsTable, ExpenseRecord>(table),
                  $$ExpenseRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$ExpenseRecordsTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn:
                                    $$ExpenseRecordsTableReferences
                                        ._vehicleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpenseRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpenseRecordsTable,
      ExpenseRecord,
      $$ExpenseRecordsTableFilterComposer,
      $$ExpenseRecordsTableOrderingComposer,
      $$ExpenseRecordsTableAnnotationComposer,
      $$ExpenseRecordsTableCreateCompanionBuilder,
      $$ExpenseRecordsTableUpdateCompanionBuilder,
      (ExpenseRecord, $$ExpenseRecordsTableReferences),
      ExpenseRecord,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$DocumentsTableCreateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String title,
      required String type,
      Value<DateTime?> startDate,
      required DateTime expirationDate,
      Value<String?> photoPath,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$DocumentsTableUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> title,
      Value<String> type,
      Value<DateTime?> startDate,
      Value<DateTime> expirationDate,
      Value<String?> photoPath,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

final class $$DocumentsTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentsTable, Document> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('documents__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, $$DocumentsTableReferences),
          Document,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime> expirationDate = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                vehicleId: vehicleId,
                title: title,
                type: type,
                startDate: startDate,
                expirationDate: expirationDate,
                photoPath: photoPath,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String title,
                required String type,
                Value<DateTime?> startDate = const Value.absent(),
                required DateTime expirationDate,
                Value<String?> photoPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                title: title,
                type: type,
                startDate: startDate,
                expirationDate: expirationDate,
                photoPath: photoPath,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentsTable, Document>(table),
                  $$DocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$DocumentsTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$DocumentsTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, $$DocumentsTableReferences),
      Document,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<int?> activeVehicleId,
      Value<String> themeMode,
      Value<bool> notificationsEnabled,
      Value<int> serviceReminderDaysBefore,
      Value<int> documentReminderDaysBefore,
      Value<String> distanceUnit,
      Value<String> fuelUnit,
      Value<DateTime> updatedAt,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<int?> activeVehicleId,
      Value<String> themeMode,
      Value<bool> notificationsEnabled,
      Value<int> serviceReminderDaysBefore,
      Value<int> documentReminderDaysBefore,
      Value<String> distanceUnit,
      Value<String> fuelUnit,
      Value<DateTime> updatedAt,
    });

final class $$AppSettingsTableReferences
    extends BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting> {
  $$AppSettingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _activeVehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('app_settings__active_vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager? get activeVehicleId {
    final $_column = $_itemColumn<int>('active_vehicle_id');
    if ($_column == null) return null;
    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activeVehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serviceReminderDaysBefore => $composableBuilder(
    column: $table.serviceReminderDaysBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get documentReminderDaysBefore => $composableBuilder(
    column: $table.documentReminderDaysBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get distanceUnit => $composableBuilder(
    column: $table.distanceUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelUnit => $composableBuilder(
    column: $table.fuelUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get activeVehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activeVehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serviceReminderDaysBefore => $composableBuilder(
    column: $table.serviceReminderDaysBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get documentReminderDaysBefore => $composableBuilder(
    column: $table.documentReminderDaysBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get distanceUnit => $composableBuilder(
    column: $table.distanceUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelUnit => $composableBuilder(
    column: $table.fuelUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get activeVehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activeVehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serviceReminderDaysBefore => $composableBuilder(
    column: $table.serviceReminderDaysBefore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get documentReminderDaysBefore => $composableBuilder(
    column: $table.documentReminderDaysBefore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get distanceUnit => $composableBuilder(
    column: $table.distanceUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fuelUnit =>
      $composableBuilder(column: $table.fuelUnit, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get activeVehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activeVehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (AppSetting, $$AppSettingsTableReferences),
          AppSetting,
          PrefetchHooks Function({bool activeVehicleId})
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> activeVehicleId = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<int> serviceReminderDaysBefore = const Value.absent(),
                Value<int> documentReminderDaysBefore = const Value.absent(),
                Value<String> distanceUnit = const Value.absent(),
                Value<String> fuelUnit = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                activeVehicleId: activeVehicleId,
                themeMode: themeMode,
                notificationsEnabled: notificationsEnabled,
                serviceReminderDaysBefore: serviceReminderDaysBefore,
                documentReminderDaysBefore: documentReminderDaysBefore,
                distanceUnit: distanceUnit,
                fuelUnit: fuelUnit,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> activeVehicleId = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<int> serviceReminderDaysBefore = const Value.absent(),
                Value<int> documentReminderDaysBefore = const Value.absent(),
                Value<String> distanceUnit = const Value.absent(),
                Value<String> fuelUnit = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                activeVehicleId: activeVehicleId,
                themeMode: themeMode,
                notificationsEnabled: notificationsEnabled,
                serviceReminderDaysBefore: serviceReminderDaysBefore,
                documentReminderDaysBefore: documentReminderDaysBefore,
                distanceUnit: distanceUnit,
                fuelUnit: fuelUnit,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  $$AppSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({activeVehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (activeVehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.activeVehicleId,
                                referencedTable: $$AppSettingsTableReferences
                                    ._activeVehicleIdTable(db),
                                referencedColumn: $$AppSettingsTableReferences
                                    ._activeVehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (AppSetting, $$AppSettingsTableReferences),
      AppSetting,
      PrefetchHooks Function({bool activeVehicleId})
    >;
typedef $$ParkingSpotsTableCreateCompanionBuilder =
    ParkingSpotsCompanion Function({
      Value<int> id,
      required int vehicleId,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> note,
      Value<String?> photoPath,
      Value<DateTime> savedAt,
    });
typedef $$ParkingSpotsTableUpdateCompanionBuilder =
    ParkingSpotsCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> note,
      Value<String?> photoPath,
      Value<DateTime> savedAt,
    });

final class $$ParkingSpotsTableReferences
    extends BaseReferences<_$AppDatabase, $ParkingSpotsTable, ParkingSpot> {
  $$ParkingSpotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('parking_spots__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ParkingSpotsTableFilterComposer
    extends Composer<_$AppDatabase, $ParkingSpotsTable> {
  $$ParkingSpotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParkingSpotsTableOrderingComposer
    extends Composer<_$AppDatabase, $ParkingSpotsTable> {
  $$ParkingSpotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParkingSpotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParkingSpotsTable> {
  $$ParkingSpotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParkingSpotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParkingSpotsTable,
          ParkingSpot,
          $$ParkingSpotsTableFilterComposer,
          $$ParkingSpotsTableOrderingComposer,
          $$ParkingSpotsTableAnnotationComposer,
          $$ParkingSpotsTableCreateCompanionBuilder,
          $$ParkingSpotsTableUpdateCompanionBuilder,
          (ParkingSpot, $$ParkingSpotsTableReferences),
          ParkingSpot,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$ParkingSpotsTableTableManager(_$AppDatabase db, $ParkingSpotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParkingSpotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParkingSpotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParkingSpotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
              }) => ParkingSpotsCompanion(
                id: id,
                vehicleId: vehicleId,
                latitude: latitude,
                longitude: longitude,
                note: note,
                photoPath: photoPath,
                savedAt: savedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
              }) => ParkingSpotsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                latitude: latitude,
                longitude: longitude,
                note: note,
                photoPath: photoPath,
                savedAt: savedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ParkingSpotsTable, ParkingSpot>(table),
                  $$ParkingSpotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$ParkingSpotsTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$ParkingSpotsTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ParkingSpotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParkingSpotsTable,
      ParkingSpot,
      $$ParkingSpotsTableFilterComposer,
      $$ParkingSpotsTableOrderingComposer,
      $$ParkingSpotsTableAnnotationComposer,
      $$ParkingSpotsTableCreateCompanionBuilder,
      $$ParkingSpotsTableUpdateCompanionBuilder,
      (ParkingSpot, $$ParkingSpotsTableReferences),
      ParkingSpot,
      PrefetchHooks Function({bool vehicleId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$MaintenanceRecordsTableTableManager get maintenanceRecords =>
      $$MaintenanceRecordsTableTableManager(_db, _db.maintenanceRecords);
  $$MaintenanceSchedulesTableTableManager get maintenanceSchedules =>
      $$MaintenanceSchedulesTableTableManager(_db, _db.maintenanceSchedules);
  $$FuelRecordsTableTableManager get fuelRecords =>
      $$FuelRecordsTableTableManager(_db, _db.fuelRecords);
  $$ExpenseRecordsTableTableManager get expenseRecords =>
      $$ExpenseRecordsTableTableManager(_db, _db.expenseRecords);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$ParkingSpotsTableTableManager get parkingSpots =>
      $$ParkingSpotsTableTableManager(_db, _db.parkingSpots);
}
