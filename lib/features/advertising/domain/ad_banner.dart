import '../data/ads_config.dart';

/// One active advertising banner returned by `GET /api/public/ads/banners`.
/// Immutable — a fresh list is fetched and replaces the previous one
/// wholesale, there's no partial-update path.
class AdBanner {
  const AdBanner({
    required this.bannerId,
    required this.bannerTitle,
    required this.imageUrl,
    required this.destinationUrl,
    required this.campaignTitle,
    required this.sectionName,
    required this.sectionCode,
  });

  final String bannerId;
  final String bannerTitle;
  final Uri imageUrl;
  final Uri destinationUrl;
  final String campaignTitle;
  final String sectionName;
  final String sectionCode;

  /// Parses one array item from the banners response. Returns `null` for
  /// anything missing a usable `bannerId`, `imageUrl`, or `destinationUrl`
  /// — the caller drops those rather than showing a broken banner. Every
  /// other field is trimmed and tolerantly defaulted to an empty string.
  static AdBanner? tryParse(Map<String, dynamic> json, AdsConfig config) {
    final bannerId = _trimmedString(json['bannerId']);
    if (bannerId == null || bannerId.isEmpty) return null;

    final imageRaw = _trimmedString(json['imageUrl']);
    final destinationRaw = _trimmedString(json['destinationUrl']);
    if (imageRaw == null || imageRaw.isEmpty) return null;
    if (destinationRaw == null || destinationRaw.isEmpty) return null;

    final Uri imageUrl;
    final Uri destinationUrl;
    try {
      imageUrl = config.resolvePublicUrl(imageRaw);
      destinationUrl = config.resolvePublicUrl(destinationRaw);
    } on FormatException {
      return null;
    }

    return AdBanner(
      bannerId: bannerId,
      bannerTitle: _trimmedString(json['bannerTitle']) ?? '',
      imageUrl: imageUrl,
      destinationUrl: destinationUrl,
      campaignTitle: _trimmedString(json['campaignTitle']) ?? '',
      sectionName: _trimmedString(json['sectionName']) ?? '',
      sectionCode: _trimmedString(json['sectionCode']) ?? '',
    );
  }

  static String? _trimmedString(Object? value) =>
      value is String ? value.trim() : null;
}
