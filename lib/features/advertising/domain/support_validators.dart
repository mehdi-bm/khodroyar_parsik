/// Input validation for the error-report and advertising-request forms.
/// Bounds mirror [AppSupportService]'s own server-contract checks exactly,
/// so a form field is rejected locally before ever reaching the network.
abstract final class SupportValidators {
  static String? errorDescription(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'شرح خطا را وارد کنید';
    if (trimmed.length < 5) return 'شرح خطا باید حداقل ۵ کاراکتر باشد';
    if (trimmed.length > 4000) return 'شرح خطا خیلی طولانی است';
    return null;
  }

  static String? fullName(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'وارد کردن نام و نام خانوادگی الزامی است';
    if (trimmed.length < 3) return 'نام واردشده خیلی کوتاه است';
    if (trimmed.length > 160) return 'نام واردشده خیلی طولانی است';
    return null;
  }

  /// Accepts Persian, Arabic-Indic, or Latin digits, plus `+`, spaces,
  /// dashes, and parentheses — only the digit count is validated.
  static String? phoneNumber(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'وارد کردن شماره تماس الزامی است';
    final digitCount = trimmed.replaceAll(RegExp(r'[^0-9۰-۹٠-٩]'), '').length;
    if (digitCount < 7 || digitCount > 20) return 'شماره تماس معتبر نیست';
    return null;
  }

  static String? province(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'وارد کردن استان الزامی است';
    if (trimmed.length < 2 || trimmed.length > 100) return 'استان معتبر نیست';
    return null;
  }

  static String? city(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'وارد کردن شهر الزامی است';
    if (trimmed.length < 2 || trimmed.length > 100) return 'شهر معتبر نیست';
    return null;
  }

  /// Optional field.
  static String? details(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.length > 4000) return 'توضیحات خیلی طولانی است';
    return null;
  }
}
