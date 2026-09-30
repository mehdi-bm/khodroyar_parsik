import 'package:flutter/foundation.dart';

/// Configuration for the Parsik ads/support API, read entirely from
/// `--dart-define`/`--dart-define-from-file` build-time environment values
/// — never hardcoded, never read from a checked-in file. [apiKey] and
/// [externalAppApiKey] are secrets and must never be logged or shown in any
/// UI/error message.
class AdsConfig {
  const AdsConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.externalAppApiKey,
    required this.appName,
    required this.platform,
    required this.sectionCode,
  });

  const AdsConfig.fromEnvironment()
    : baseUrl = const String.fromEnvironment(
        'ADS_BASE_URL',
        defaultValue: 'https://ads.parsikonline.ir/',
      ),
      apiKey = const String.fromEnvironment('ADS_API_KEY'),
      externalAppApiKey = const String.fromEnvironment(
        'ADS_EXTERNAL_APP_API_KEY',
      ),
      appName = const String.fromEnvironment(
        'ADS_APP_NAME',
        defaultValue: 'parsik_khodroyar',
      ),
      platform = const String.fromEnvironment(
        'ADS_PLATFORM',
        defaultValue: 'Android',
      ),
      sectionCode = const String.fromEnvironment('ADS_SECTION_CODE');

  final String baseUrl;
  final String apiKey;
  final String externalAppApiKey;
  final String appName;
  final String platform;
  final String sectionCode;

  /// Both API keys must be present before any request is attempted — a
  /// missing key means the feature is silently disabled rather than sent
  /// with an empty/placeholder credential.
  bool get isConfigured => apiKey.isNotEmpty && externalAppApiKey.isNotEmpty;

  Uri get baseUri => Uri.parse(baseUrl);

  Uri apiUri(String path, {Map<String, String>? queryParameters}) {
    final base = baseUri;
    final basePath = base.path.endsWith('/')
        ? base.path.substring(0, base.path.length - 1)
        : base.path;
    final combinedPath = '$basePath/$path';
    return base.replace(path: combinedPath, queryParameters: queryParameters);
  }

  /// Resolves a possibly-relative URL (banner image/destination) against
  /// [baseUri]. Only ever returns an `https` URL, except in debug builds
  /// where `http` is allowed for local testing — production release builds
  /// reject `http` outright.
  Uri resolvePublicUrl(String value) {
    final parsed = Uri.parse(value);
    final resolved = parsed.hasScheme ? parsed : baseUri.resolveUri(parsed);
    final schemeOk =
        resolved.scheme == 'https' || (kDebugMode && resolved.scheme == 'http');
    if (!schemeOk) {
      throw const FormatException('آدرس نامعتبر است');
    }
    return resolved;
  }
}
