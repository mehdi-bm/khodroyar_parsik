/// Every failure mode the ads/support API surface can hit, each carrying
/// the exact Persian message the UI is required to show — callers never
/// need to know the underlying HTTP status or interpret raw server text.
enum AdsErrorKind {
  notConfigured,
  validation,
  auth,
  rateLimited,
  network,
  invalidResponse,
  server,
}

class AdsApiException implements Exception {
  const AdsApiException(this.kind);

  final AdsErrorKind kind;

  String get message => switch (kind) {
    AdsErrorKind.notConfigured => 'پیکربندی تبلیغات کامل نیست.',
    AdsErrorKind.validation =>
      'اطلاعات واردشده معتبر نیست؛ فیلدها را بررسی کنید.',
    AdsErrorKind.auth =>
      'ارتباط امن برنامه با سرور تأیید نشد؛ نسخه برنامه را به‌روزرسانی کنید.',
    AdsErrorKind.rateLimited =>
      'تعداد درخواست‌ها زیاد است؛ کمی بعد دوباره تلاش کنید.',
    AdsErrorKind.network => 'اتصال اینترنت را بررسی و دوباره تلاش کنید.',
    AdsErrorKind.invalidResponse => 'پاسخ سرور معتبر نیست؛ دوباره تلاش کنید.',
    // 500 and anything unrecognized — deliberately generic, never surfaces
    // server internals to the user.
    AdsErrorKind.server => 'خطایی در سرور رخ داد؛ کمی بعد دوباره تلاش کنید.',
  };

  /// Maps an HTTP status code from the ads/support API to the right
  /// exception kind. Only 2xx (handled by callers before this is reached)
  /// and these documented codes have specific meaning; everything else
  /// (including undocumented 4xx) falls back to [AdsErrorKind.server] so no
  /// raw status/body ever reaches the user.
  factory AdsApiException.fromStatusCode(int statusCode) {
    return switch (statusCode) {
      400 => const AdsApiException(AdsErrorKind.validation),
      401 || 403 => const AdsApiException(AdsErrorKind.auth),
      429 => const AdsApiException(AdsErrorKind.rateLimited),
      _ => const AdsApiException(AdsErrorKind.server),
    };
  }

  @override
  String toString() => 'AdsApiException(${kind.name})';
}
