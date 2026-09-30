import 'dart:convert';

import 'package:caryar/features/advertising/data/ads_http_transport.dart';

/// One recorded call made through a [FakeAdsHttpTransport].
class RecordedAdsRequest {
  const RecordedAdsRequest({
    required this.method,
    required this.url,
    required this.headers,
    required this.body,
  });

  final String method;
  final Uri url;
  final Map<String, String> headers;
  final String? body;
}

/// A programmable [AdsHttpTransport] for unit-testing
/// [AdvertisingService]/[AppSupportService] without any real networking —
/// records every call made through it and returns whatever response (or
/// throws whatever [AdsTransportException]) the test configures.
class FakeAdsHttpTransport implements AdsHttpTransport {
  final List<RecordedAdsRequest> requests = [];

  /// Set to a function to control the response/error per call; defaults to
  /// always returning [defaultResponse].
  AdsHttpResponse Function(RecordedAdsRequest request)? responder;
  AdsHttpResponse defaultResponse = const AdsHttpResponse(
    statusCode: 200,
    bodyBytes: [],
  );

  bool closed = false;

  @override
  Future<AdsHttpResponse> send({
    required String method,
    required Uri url,
    required Map<String, String> headers,
    String? body,
  }) async {
    final request = RecordedAdsRequest(
      method: method,
      url: url,
      headers: headers,
      body: body,
    );
    requests.add(request);
    return responder?.call(request) ?? defaultResponse;
  }

  @override
  void close() => closed = true;
}

AdsHttpResponse jsonResponse(int statusCode, Object? body) {
  return AdsHttpResponse(
    statusCode: statusCode,
    bodyBytes: utf8.encode(jsonEncode(body)),
  );
}

AdsHttpResponse emptyResponse(int statusCode) {
  return AdsHttpResponse(statusCode: statusCode, bodyBytes: const []);
}
