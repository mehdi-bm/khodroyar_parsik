import '../../../core/utils/grouped_number_input.dart';

/// Input validation for the vehicle form. Persian error messages, matching
/// the app's rule against exposing raw/technical errors to the user.
abstract final class VehicleValidators {
  static String? name(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'وارد کردن نام خودرو الزامی است';
    if (trimmed.length > 100) return 'نام خودرو خیلی طولانی است';
    return null;
  }

  /// [value] comes from a [GroupedNumberInputFormatter] field — grouped and
  /// in Persian digits — so it's ungrouped back to plain Latin digits
  /// before parsing.
  static String? mileage(String? value) {
    final original = value?.trim() ?? '';
    if (original.isEmpty) return 'وارد کردن کیلومتر الزامی است';
    final parsed = int.tryParse(ungroupDigits(original));
    if (parsed == null) return 'کیلومتر باید عدد باشد';
    if (parsed < 0) return 'کیلومتر نمی‌تواند منفی باشد';
    return null;
  }

  /// Optional field — a loose sanity range on the Persian (Jalali) calendar,
  /// not a real manufacturer-data check.
  static String? modelYear(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    final parsed = int.tryParse(ungroupDigits(trimmed));
    if (parsed == null) return 'سال باید عدد باشد';
    if (parsed < 1300 || parsed > 1500) return 'سال معتبر نیست';
    return null;
  }
}
