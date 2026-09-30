import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'ads_exceptions.dart';

/// Raw HTTP response returned by [AdsHttpTransport.send] — status code plus
/// body bytes, already capped at the transport's response-size limit.
class AdsHttpResponse {
  const AdsHttpResponse({required this.statusCode, required this.bodyBytes});

  final int statusCode;
  final List<int> bodyBytes;

  String get bodyText => utf8.decode(bodyBytes, allowMalformed: true);
}

/// A transport-layer failure (timeout, no connection, response rejected
/// before a status code could be meaningfully returned) — always maps to
/// either [AdsErrorKind.network] or [AdsErrorKind.invalidResponse], never
/// carries raw exception text into anything user-facing.
class AdsTransportException implements Exception {
  const AdsTransportException(this.kind);

  final AdsErrorKind kind;

  @override
  String toString() => 'AdsTransportException(${kind.name})';
}

abstract interface class AdsHttpTransport {
  Future<AdsHttpResponse> send({
    required String method,
    required Uri url,
    required Map<String, String> headers,
    String? body,
  });

  void close();
}

/// Same-origin check (scheme + host + port) — the sole gate for whether a
/// redirect target may be followed with the original request's headers
/// attached. A standalone, pure function so this security-critical
/// decision is unit-testable without any real networking.
bool isSameOrigin(Uri a, Uri b) =>
    a.scheme == b.scheme && a.host == b.host && a.port == b.port;

const Set<int> _redirectStatusCodes = {301, 302, 303, 307, 308};

/// A `dart:io`-backed [AdsHttpTransport] with deliberately manual redirect
/// handling. `dart:io`'s own automatic redirect following
/// (`HttpClientRequest.followRedirects`, default `true`) does not
/// guarantee stripping custom headers on a cross-host hop — only the
/// standard `Authorization` header gets that treatment — so leaving it on
/// would risk resending `X-API-KEY`/`X-EXTERNAL-APP-API-KEY` to whatever
/// host a redirect happens to point at. Redirects are therefore followed
/// by hand, capped at [maxRedirects] hops, and only when same-origin.
class IoAdsHttpTransport implements AdsHttpTransport {
  IoAdsHttpTransport({
    Duration connectTimeout = const Duration(seconds: 8),
    this._receiveTimeout = const Duration(seconds: 12),
    this._maxRedirects = 3,
    this._maxResponseBytes = 2 * 1024 * 1024,
  }) : _client = HttpClient()..connectionTimeout = connectTimeout;

  final HttpClient _client;
  final Duration _receiveTimeout;
  final int _maxRedirects;
  final int _maxResponseBytes;

  @override
  Future<AdsHttpResponse> send({
    required String method,
    required Uri url,
    required Map<String, String> headers,
    String? body,
  }) async {
    try {
      // Connect time is bounded by HttpClient.connectionTimeout above; this
      // wraps the whole request+response-read (including any same-origin
      // redirect hops) so a slow/hanging server can't stall the caller
      // indefinitely.
      return await _sendOnce(
        method: method,
        url: url,
        headers: headers,
        body: body,
        originalOrigin: url,
        redirectsLeft: _maxRedirects,
      ).timeout(_receiveTimeout);
    } on TimeoutException {
      throw const AdsTransportException(AdsErrorKind.network);
    } on SocketException {
      throw const AdsTransportException(AdsErrorKind.network);
    } on HttpException {
      throw const AdsTransportException(AdsErrorKind.network);
    } on HandshakeException {
      throw const AdsTransportException(AdsErrorKind.network);
    } on AdsTransportException {
      rethrow;
    }
  }

  Future<AdsHttpResponse> _sendOnce({
    required String method,
    required Uri url,
    required Map<String, String> headers,
    required String? body,
    required Uri originalOrigin,
    required int redirectsLeft,
  }) async {
    final request = await _client.openUrl(method, url);
    request.followRedirects = false;
    headers.forEach(request.headers.set);
    if (body != null) {
      final bytes = utf8.encode(body);
      request.headers.contentLength = bytes.length;
      request.add(bytes);
    }
    final response = await request.close();

    if (_redirectStatusCodes.contains(response.statusCode)) {
      final location = response.headers.value(HttpHeaders.locationHeader);
      final target = location == null ? null : url.resolve(location);
      if (target != null &&
          redirectsLeft > 0 &&
          isSameOrigin(originalOrigin, target)) {
        await response.drain<void>();
        // A 303 always redirects as a GET with no body, per HTTP semantics.
        final nextMethod = response.statusCode == 303 ? 'GET' : method;
        final nextBody = response.statusCode == 303 ? null : body;
        return _sendOnce(
          method: nextMethod,
          url: target,
          headers: headers,
          body: nextBody,
          originalOrigin: originalOrigin,
          redirectsLeft: redirectsLeft - 1,
        );
      }
      // Cross-origin or out-of-hops redirect: never follow it with our
      // secret headers attached.
      await response.drain<void>();
      throw const AdsTransportException(AdsErrorKind.invalidResponse);
    }

    final bytes = <int>[];
    await for (final chunk in response) {
      bytes.addAll(chunk);
      if (bytes.length > _maxResponseBytes) {
        throw const AdsTransportException(AdsErrorKind.invalidResponse);
      }
    }
    return AdsHttpResponse(statusCode: response.statusCode, bodyBytes: bytes);
  }

  @override
  void close() => _client.close(force: true);
}
