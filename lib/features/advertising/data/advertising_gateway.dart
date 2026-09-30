import '../domain/ad_banner.dart';

/// Everything the ad-banner feature needs from the Parsik ads API. Kept as
/// an interface so widget/cubit tests can supply a fake instead of hitting
/// the network.
abstract interface class AdvertisingGateway {
  /// False when either API key is missing — callers must not attempt any
  /// request in that case and should disable the feature with a clear
  /// message instead of sending an empty/placeholder credential.
  bool get isConfigured;

  Uri resolvePublicUrl(String value);

  /// Returns the currently active banners for this app/platform/section.
  /// An empty list means no active campaign — never invent placeholder
  /// content for that case.
  Future<List<AdBanner>> fetchBanners();

  /// Registers a click for [bannerId] and returns the destination URL from
  /// the click-registration response (the authoritative one to open).
  Future<Uri> registerClick({
    required String bannerId,
    required String externalUserId,
  });

  void close();
}
