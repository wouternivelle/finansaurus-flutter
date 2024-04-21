import 'dart:convert';

import 'package:authenticated_http_client/authenticated_http_client.dart';
import 'package:cache/cache.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('AuthenticatedHttpClient', () {
    late http.Client httpClient;
    late AuthenticatedHttpClient authenticatedHttpClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      authenticatedHttpClient = AuthenticatedHttpClient(httpClient: httpClient);
    });

    test(
        'creates AuthenticatedHttpCLient instance without required http client',
        () {
      expect(AuthenticatedHttpClient(), isNotNull);
    });

    test('uses the correct headers when making a get request', () async {
      CacheClient().write(key: 'AUTH_TOKEN', value: 'token');

      final headers = {
        'authorization': 'Bearer token',
        'content-type': 'application/json'
      };
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('{}');
      when(() => httpClient.get(any(), headers: headers))
          .thenAnswer((_) async => response);

      await authenticatedHttpClient.get('test_url');

      verify(() => httpClient.get(Uri.parse('test_url'), headers: headers))
          .called(1);
    });

    test(
        'uses the correct headers and encodes the json body when making a post request',
        () async {
      CacheClient().write(key: 'AUTH_TOKEN', value: 'token');

      final data = {'key1': 'value1', 'key2': 'value2'};
      final headers = {
        'authorization': 'Bearer token',
        'content-type': 'application/json'
      };
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('{}');
      when(() =>
              httpClient.post(any(), headers: headers, body: jsonEncode(data)))
          .thenAnswer((_) async => response);

      await authenticatedHttpClient.post('test_url', data);

      verify(() => httpClient.post(Uri.parse('test_url'),
          headers: headers, body: jsonEncode(data))).called(1);
    });
  });
}
