import '../../../core/utils/grouped_number_input.dart';
import '../../../core/utils/decimal_input.dart';

/// Input validation for the fuel record form. Persian error messages,
/// matching the app's rule against exposing raw/technical errors. Mileage
/// and totalCost use [GroupedNumberInputFormatter] (grouped, Persian
/// digits), so their raw text goes through [ungroupDigits] first;
/// fuelAmount is a decimal field and stays plain Latin numeric input.
abstract final class FuelValidators {
  static String? mileage(
    String? value, {
    int? previousMileage,
    int? nextMileage,
  }) {
    final original = value?.trim() ?? '';
    if (original.isEmpty) return 'وارد کردن کیلومتر الزامی است';
    final parsed = int.tryParse(ungroupDigits(original));
    if (parsed == null) return 'کیلومتر باید عدد باشد';
    if (parsed < 0) return 'کیلومتر نمی‌تواند منفی باشد';
    if (previousMileage != null && parsed <= previousMileage) {
      return 'باید بیشتر از کیلومتر سوخت‌گیری قبلی باشد';
    }
    if (nextMileage != null && parsed >= nextMileage) {
      return 'باید کمتر از کیلومتر سوخت‌گیری بعدی باشد';
    }
    return null;
  }

  static String? fuelAmount(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'وارد کردن مقدار سوخت الزامی است';
    final parsed = double.tryParse(normalizeDecimalInput(trimmed));
    if (parsed == null || !parsed.isFinite) return 'مقدار سوخت باید عدد باشد';
    if (parsed <= 0) return 'مقدار سوخت باید بیشتر از صفر باشد';
    return null;
  }

  static String? totalCost(String? value) {
    final original = value?.trim() ?? '';
    if (original.isEmpty) return 'وارد کردن هزینه الزامی است';
    final parsed = int.tryParse(ungroupDigits(original));
    if (parsed == null) return 'هزینه باید عدد باشد';
    if (parsed <= 0) return 'هزینه باید بیشتر از صفر باشد';
    return null;
  }
}
