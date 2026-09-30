import '../../../core/utils/grouped_number_input.dart';

/// Input validation for the maintenance record form. Persian error
/// messages, matching the app's rule against exposing raw/technical errors.
/// The numeric fields all use [GroupedNumberInputFormatter], so their raw
/// text is grouped and in Persian digits — [ungroupDigits] converts back to
/// plain Latin digits before parsing.
abstract final class MaintenanceValidators {
  static String? title(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'وارد کردن عنوان الزامی است';
    if (trimmed.length > 150) return 'عنوان خیلی طولانی است';
    return null;
  }

  static String? mileage(String? value) {
    final original = value?.trim() ?? '';
    if (original.isEmpty) return 'وارد کردن کیلومتر الزامی است';
    final parsed = int.tryParse(ungroupDigits(original));
    if (parsed == null) return 'کیلومتر باید عدد باشد';
    if (parsed < 0) return 'کیلومتر نمی‌تواند منفی باشد';
    return null;
  }

  /// Optional — defaults to zero when left blank.
  static String? cost(String? value) {
    final original = value?.trim() ?? '';
    if (original.isEmpty) return null;
    final parsed = int.tryParse(ungroupDigits(original));
    if (parsed == null) return 'هزینه باید عدد باشد';
    if (parsed < 0) return 'هزینه نمی‌تواند منفی باشد';
    return null;
  }

  /// Optional — if provided, must be after the service's own mileage.
  static String? nextServiceMileage(
    String? value, {
    required int serviceMileage,
  }) {
    final original = value?.trim() ?? '';
    if (original.isEmpty) return null;
    final parsed = int.tryParse(ungroupDigits(original));
    if (parsed == null) return 'کیلومتر باید عدد باشد';
    if (parsed <= serviceMileage) return 'باید بیشتر از کیلومتر این سرویس باشد';
    return null;
  }
}
