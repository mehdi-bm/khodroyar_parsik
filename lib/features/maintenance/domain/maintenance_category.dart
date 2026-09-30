/// Suggested maintenance categories from the product spec. Stored in the DB
/// as the enum's `name` (free text column, not a DB-level enum) so a future
/// custom category never requires a migration.
enum MaintenanceCategory {
  engineOil,
  oilFilter,
  airFilter,
  cabinFilter,
  fuelFilter,
  brakePads,
  battery,
  tires,
  sparkPlugs,
  timingBelt,
  generalService,
  other;

  String get label => switch (this) {
    MaintenanceCategory.engineOil => 'روغن موتور',
    MaintenanceCategory.oilFilter => 'فیلتر روغن',
    MaintenanceCategory.airFilter => 'فیلتر هوا',
    MaintenanceCategory.cabinFilter => 'فیلتر کابین',
    MaintenanceCategory.fuelFilter => 'فیلتر سوخت',
    MaintenanceCategory.brakePads => 'لنت ترمز',
    MaintenanceCategory.battery => 'باتری',
    MaintenanceCategory.tires => 'لاستیک',
    MaintenanceCategory.sparkPlugs => 'شمع موتور',
    MaintenanceCategory.timingBelt => 'تسمه تایم',
    MaintenanceCategory.generalService => 'سرویس عمومی',
    MaintenanceCategory.other => 'سایر',
  };

  static MaintenanceCategory fromStorageKey(String key) {
    return MaintenanceCategory.values.firstWhere(
      (category) => category.name == key,
      orElse: () => MaintenanceCategory.other,
    );
  }
}
