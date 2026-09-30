/// Input validation for the document form. Persian error messages,
/// matching the app's rule against exposing raw/technical errors.
abstract final class DocumentValidators {
  static String? title(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'وارد کردن عنوان الزامی است';
    if (trimmed.length > 150) return 'عنوان خیلی طولانی است';
    return null;
  }

  /// The expiration date is picked, not typed, so there's no string to
  /// validate — this just centralizes the "must be after the start date"
  /// rule so the form and any future caller apply it identically.
  static String? expirationDate({
    DateTime? startDate,
    required DateTime expirationDate,
  }) {
    if (startDate != null && !expirationDate.isAfter(startDate)) {
      return 'تاریخ انقضا باید بعد از تاریخ شروع باشد';
    }
    return null;
  }
}
