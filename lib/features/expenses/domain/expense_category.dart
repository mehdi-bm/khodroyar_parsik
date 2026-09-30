/// Standalone vehicle expense categories. "Maintenance" and "Fuel" are
/// deliberately NOT included here — those costs are already captured by
/// [MaintenanceRecords]/[FuelRecords] respectively, and the dashboard's
/// monthly total sums all three tables together, so a cost must live in
/// exactly one of them or it would be double-counted (see the doc comment
/// on the ExpenseRecords table).
enum ExpenseCategory {
  insurance,
  inspection,
  tires,
  battery,
  carWash,
  accessories,
  repair,
  other;

  String get label => switch (this) {
    ExpenseCategory.insurance => 'بیمه',
    ExpenseCategory.inspection => 'معاینه فنی',
    ExpenseCategory.tires => 'لاستیک',
    ExpenseCategory.battery => 'باتری',
    ExpenseCategory.carWash => 'کارواش',
    ExpenseCategory.accessories => 'لوازم جانبی',
    ExpenseCategory.repair => 'تعمیرات',
    ExpenseCategory.other => 'سایر',
  };

  static ExpenseCategory fromStorageKey(String key) {
    return ExpenseCategory.values.firstWhere(
      (category) => category.name == key,
      orElse: () => ExpenseCategory.other,
    );
  }
}
