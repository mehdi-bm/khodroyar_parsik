import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/advertising/data/ads_exceptions.dart';
import 'package:caryar/features/advertising/data/ads_http_transport.dart';

void main() {
  group('isSameOrigin', () {
    test('true for identical scheme/host/port', () {
      expect(
        isSameOrigin(
          Uri.parse('https://ads.parsikonline.ir/a'),
          Uri.parse('https://ads.parsikonline.ir/b'),
        ),
        isTrue,
      );
    });

    test('false for a different host', () {
      expect(
        isSameOrigin(
          Uri.parse('https://ads.parsikonline.ir/a'),
          Uri.parse('https://evil.example.com/a'),
        ),
        isFalse,
      );
    });

    test('false for a different scheme', () {
      expect(
        isSameOrigin(
          Uri.parse('https://ads.parsikonline.ir/a'),
          Uri.parse('http://ads.parsikonline.ir/a'),
        ),
        isFalse,
      );
    });

    test('false for a different port', () {
      expect(
        isSameOrigin(
          Uri.parse('https://ads.parsikonline.ir:443/a'),
          Uri.parse('https://ads.parsikonline.ir:8443/a'),
        ),
        isFalse,
      );
    });
  });

  group('IoAdsHttpTransport against a local server', () {
    late HttpServer server;
    late IoAdsHttpTransport transport;
    late Uri origin;

    setUp(() async {
      server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      origin = Uri(scheme: 'http', host: 'localhost', port: server.port);
      transport = IoAdsHttpTransport(
        connectTimeout: const Duration(seconds: 2),
        receiveTimeout: const Duration(seconds: 2),
        maxResponseBytes: 1024,
      );
    });

    tearDown(() async {
      transport.close();
      await server.close(force: true);
    });

    test('sends the given method, headers, and body', () async {
      String? receivedMethod;
      String? receivedHeader;
      String? receivedBody;
      server.listen((request) async {
        receivedMethod = request.method;
        receivedHeader = request.headers.value('x-api-key');
        receivedBody = await utf8.decoder.bind(request).join();
        request.response.statusCode = 201;
        request.response.write('{"ok":true}');
        await request.response.close();
      });

      final response = await transport.send(
        method: 'POST',
        url: origin.replace(path: '/api/public/ads/click'),
        headers: const {'X-API-KEY': 'secret-key'},
        body: '{"bannerId":"abc"}',
      );

      expect(receivedMethod, 'POST');
      expect(receivedHeader, 'secret-key');
      expect(receivedBody, '{"bannerId":"abc"}');
      expect(response.statusCode, 201);
      expect(response.bodyText, '{"ok":true}');
    });

    test(
      'follows a same-origin redirect and returns the final response',
      () async {
        server.listen((request) async {
          if (request.uri.path == '/first') {
            request.response.statusCode = 302;
            request.response.headers.set('location', '/second');
            await request.response.close();
          } else {
            request.response.statusCode = 200;
            request.response.write('final');
            await request.response.close();
          }
        });

        final response = await transport.send(
          method: 'GET',
          url: origin.replace(path: '/first'),
          headers: const {},
        );

        expect(response.statusCode, 200);
        expect(response.bodyText, 'final');
      },
    );

    test('gives up after more than maxRedirects same-origin hops', () async {
      transport.close();
      transport = IoAdsHttpTransport(maxRedirects: 2);
      var hop = 0;
      server.listen((request) async {
        hop++;
        request.response.statusCode = 302;
        request.response.headers.set('location', '/hop$hop');
        await request.response.close();
      });

      await expectLater(
        transport.send(
          method: 'GET',
          url: origin.replace(path: '/hop0'),
          headers: const {},
        ),
        throwsA(
          isA<AdsTransportException>().having(
            (e) => e.kind,
            'kind',
            AdsErrorKind.invalidResponse,
          ),
        ),
      );
    });

    test(
      'rejects a redirect to a different origin without following it',
      () async {
        server.listen((request) async {
          request.response.statusCode = 302;
          request.response.headers.set(
            'location',
            'https://evil.example.com/steal',
          );
          await request.response.close();
        });

        await expectLater(
          transport.send(
            method: 'GET',
            url: origin.replace(path: '/redirect-away'),
            headers: const {'X-API-KEY': 'should-not-leak'},
          ),
          throwsA(isA<AdsTransportException>()),
        );
      },
    );

    test('rejects a response larger than the configured cap', () async {
      server.listen((request) async {
        request.response.statusCode = 200;
        request.response.write('x' * 2000); // > 1024-byte cap set in setUp
        await request.response.close();
      });

      await expectLater(
        transport.send(
          method: 'GET',
          url: origin.replace(path: '/big'),
          headers: const {},
        ),
        throwsA(isA<AdsTransportException>()),
      );
    });

    test(
      'maps a connection failure to a network AdsTransportException',
      () async {
        await server.close(force: true);

        await expectLater(
          transport.send(
            method: 'GET',
            url: origin.replace(path: '/anything'),
            headers: const {},
          ),
          throwsA(
            isA<AdsTransportException>().having(
              (e) => e.kind,
              'kind',
              AdsErrorKind.network,
            ),
          ),
        );
      },
    );
  });
}
