import 'package:geolocator/geolocator.dart';

import '../domain/location_result.dart';

abstract interface class LocationProvider {
  Future<LocationResult> getCurrentLocation();
}

/// Real implementation backed by `geolocator` — handles the service-enabled
/// check and the runtime permission request flow before reading a fix, so
/// callers only ever deal with [LocationResult].
class GeolocatorLocationProvider implements LocationProvider {
  @override
  Future<LocationResult> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const LocationFailure(LocationFailureReason.serviceDisabled);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const LocationFailure(LocationFailureReason.permissionDenied);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return const LocationFailure(
        LocationFailureReason.permissionDeniedForever,
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      return LocationSuccess(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (_) {
      return const LocationFailure(LocationFailureReason.error);
    }
  }
}
