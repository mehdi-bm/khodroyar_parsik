import 'dart:convert';

import '../domain/ad_banner.dart';
import 'ads_config.dart';
import 'ads_exceptions.dart';
import 'ads_http_transport.dart';
import 'advertising_gateway.dart';

/// Real implementation of [AdvertisingGateway], talking to the Parsik ads
/// API exactly per its documented contract (see the reusable ads-banner
/// integration prompt this feature was built from).
class AdvertisingService implements AdvertisingGateway {
  AdvertisingService(this._config, {AdsHttpTransport? transport})
    : _transport = transport ?? IoAdsHttpTransport();

  final AdsConfig _config;
  final AdsHttpTransport _transport;

  @override
  bool get isConfigured => _config.isConfigured;

  @override
  Uri resolvePublicUrl(String value) => _config.resolvePublicUrl(value);

  Map<String, String> get _authHeaders => {
    'Accept': 'application/json',
    'X-API-KEY': _config.apiKey,
    'X-EXTERNAL-APP-API-KEY': _config.externalAppApiKey,
  };

  @override
  Future<List<AdBanner>> fetchBanners() async {
    if (!isConfigured) {
      throw const AdsApiException(AdsErrorKind.notConfigured);
    }

    final query = <String, String>{'platform': _config.platform};
    if (_config.sectionCode.isNotEmpty) {
      query['sectionCode'] = _config.sectionCode;
    }
    final uri = _config.apiUri(
      'api/public/ads/banners',
      queryParameters: query,
    );

    final response = await _request('GET', uri, headers: _authHeaders);
    if (response.statusCode != 200) {
      throw AdsApiException.fromStatusCode(response.statusCode);
    }

    final decoded = _decodeJson(response.bodyText);
    if (decoded == null) return const [];
    if (decoded is! List) {
      throw const AdsApiException(AdsErrorKind.invalidResponse);
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map((item) => AdBanner.tryParse(item, _config))
        .whereType<AdBanner>()
        .toList(growable: false);
  }

  @override
  Future<Uri> registerClick({
    required String bannerId,
    required String externalUserId,
  }) async {
    if (!isConfigured) {
      throw const AdsApiException(AdsErrorKind.notConfigured);
    }

    final uri = _config.apiUri('api/public/ads/click');
    final body = jsonEncode({
      'bannerId': bannerId,
      'externalUserId': externalUserId,
      'appName': _config.appName,
      'platform': _config.platform,
      'referrerUrl':
          'https://parsikhesab.com/apps/${_config.appName}/ads/$bannerId',
    });

    final response = await _request(
      'POST',
      uri,
      headers: {
        ..._authHeaders,
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: body,
    );
    if (response.statusCode != 201) {
      throw AdsApiException.fromStatusCode(response.statusCode);
    }

    final decoded = _decodeJson(response.bodyText);
    if (decoded is! Map<String, dynamic>) {
      throw const AdsApiException(AdsErrorKind.invalidResponse);
    }
    final destinationUrl = decoded['destinationUrl'];
    if (destinationUrl is! String || destinationUrl.trim().isEmpty) {
      throw const AdsApiException(AdsErrorKind.invalidResponse);
    }
    try {
      return _config.resolvePublicUrl(destinationUrl.trim());
    } on FormatException {
      throw const AdsApiException(AdsErrorKind.invalidResponse);
    }
  }

  Future<AdsHttpResponse> _request(
    String method,
    Uri uri, {
    required Map<String, String> headers,
    String? body,
  }) async {
    try {
      return await _transport.send(
        method: method,
        url: uri,
        headers: headers,
        body: body,
      );
    } on AdsTransportException catch (e) {
      throw AdsApiException(e.kind);
    }
  }

  /// `null` on an empty body (no active campaign); throws on malformed
  /// JSON rather than treating it as empty.
  Object? _decodeJson(String bodyText) {
    final trimmed = bodyText.trim();
    if (trimmed.isEmpty) return null;
    try {
      return jsonDecode(trimmed);
    } on FormatException {
      throw const AdsApiException(AdsErrorKind.invalidResponse);
    }
  }

  @override
  void close() => _transport.close();
}
