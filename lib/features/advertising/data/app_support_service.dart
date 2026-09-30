import 'dart:convert';

import '../domain/submission_receipt.dart';
import 'ads_config.dart';
import 'ads_exceptions.dart';
import 'ads_http_transport.dart';
import 'app_support_gateway.dart';

/// Real implementation of [AppSupportGateway] — submits to the same Parsik
/// API as the ads banners, reusing [AdsConfig] and the shared
/// [AdsHttpTransport] (same timeouts, redirect handling, and header
/// policy) rather than a parallel HTTP stack.
class AppSupportService implements AppSupportGateway {
  AppSupportService(this._config, {AdsHttpTransport? transport})
    : _transport = transport ?? IoAdsHttpTransport();

  final AdsConfig _config;
  final AdsHttpTransport _transport;

  @override
  bool get isConfigured => _config.isConfigured;

  Map<String, String> get _headers => {
    'Accept': 'application/json',
    'Content-Type': 'application/json; charset=utf-8',
    'X-API-KEY': _config.apiKey,
    'X-EXTERNAL-APP-API-KEY': _config.externalAppApiKey,
  };

  @override
  Future<SubmissionReceipt> submitErrorReport({
    required String description,
  }) async {
    // Deliberately `async` even though the body could otherwise return the
    // `_submit` future directly — without it, the validation `throw`s below
    // would raise synchronously (before any Future exists), which breaks
    // every `await`/`expectLater`-style caller expecting a rejected Future
    // rather than a synchronous exception.
    final trimmed = description.trim();
    if (trimmed.length < 5 || trimmed.length > 4000) {
      throw const AdsApiException(AdsErrorKind.validation);
    }
    return _submit('api/public/app-submissions/error-reports', {
      'description': trimmed,
    });
  }

  @override
  Future<SubmissionReceipt> submitAdvertisingRequest({
    required String fullName,
    required String phoneNumber,
    required String province,
    required String city,
    required String details,
  }) async {
    final trimmedName = fullName.trim();
    final trimmedPhone = phoneNumber.trim();
    final trimmedProvince = province.trim();
    final trimmedCity = city.trim();
    final trimmedDetails = details.trim();

    if (trimmedName.length < 3 || trimmedName.length > 160) {
      throw const AdsApiException(AdsErrorKind.validation);
    }
    // Matches SupportValidators.phoneNumber — accepts Persian (۰-۹) and
    // Arabic-Indic (٠-٩) digits too, not just Latin.
    final phoneDigitCount = trimmedPhone
        .replaceAll(RegExp(r'[^0-9۰-۹٠-٩]'), '')
        .length;
    if (phoneDigitCount < 7 || phoneDigitCount > 20) {
      throw const AdsApiException(AdsErrorKind.validation);
    }
    if (trimmedProvince.length < 2 || trimmedProvince.length > 100) {
      throw const AdsApiException(AdsErrorKind.validation);
    }
    if (trimmedCity.length < 2 || trimmedCity.length > 100) {
      throw const AdsApiException(AdsErrorKind.validation);
    }
    if (trimmedDetails.length > 4000) {
      throw const AdsApiException(AdsErrorKind.validation);
    }

    return _submit('api/public/app-submissions/advertising-requests', {
      'fullName': trimmedName,
      'phoneNumber': trimmedPhone,
      'province': trimmedProvince,
      'city': trimmedCity,
      if (trimmedDetails.isNotEmpty) 'details': trimmedDetails,
    });
  }

  Future<SubmissionReceipt> _submit(
    String path,
    Map<String, dynamic> payload,
  ) async {
    if (!isConfigured) {
      throw const AdsApiException(AdsErrorKind.notConfigured);
    }

    final uri = _config.apiUri(path);
    final AdsHttpResponse response;
    try {
      response = await _transport.send(
        method: 'POST',
        url: uri,
        headers: _headers,
        body: jsonEncode(payload),
      );
    } on AdsTransportException catch (e) {
      throw AdsApiException(e.kind);
    }

    if (response.statusCode != 201) {
      throw AdsApiException.fromStatusCode(response.statusCode);
    }

    final trimmed = response.bodyText.trim();
    if (trimmed.isEmpty) {
      throw const AdsApiException(AdsErrorKind.invalidResponse);
    }
    final Object? decoded;
    try {
      decoded = jsonDecode(trimmed);
    } on FormatException {
      throw const AdsApiException(AdsErrorKind.invalidResponse);
    }
    if (decoded is! Map<String, dynamic>) {
      throw const AdsApiException(AdsErrorKind.invalidResponse);
    }
    final receipt = SubmissionReceipt.tryParse(decoded);
    if (receipt == null) {
      throw const AdsApiException(AdsErrorKind.invalidResponse);
    }
    return receipt;
  }

  @override
  void close() => _transport.close();
}
