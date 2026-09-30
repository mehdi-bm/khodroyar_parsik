enum LocationFailureReason {
  permissionDenied,
  permissionDeniedForever,
  serviceDisabled,
  error,
}

sealed class LocationResult {
  const LocationResult();
}

class LocationSuccess extends LocationResult {
  const LocationSuccess({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}

class LocationFailure extends LocationResult {
  const LocationFailure(this.reason);

  final LocationFailureReason reason;

  String get message => switch (reason) {
    LocationFailureReason.permissionDenied =>
      'دسترسی به موقعیت مکانی داده نشد.',
    LocationFailureReason.permissionDeniedForever =>
      'دسترسی به موقعیت مکانی مسدود شده است؛ از تنظیمات گوشی فعال کنید.',
    LocationFailureReason.serviceDisabled =>
      'سرویس موقعیت مکانی (GPS) گوشی خاموش است.',
    LocationFailureReason.error => 'دریافت موقعیت مکانی انجام نشد.',
  };
}
