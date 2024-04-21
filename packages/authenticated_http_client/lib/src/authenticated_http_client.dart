import 'dart:convert';
import 'dart:io';

import 'package:cache/cache.dart';
import 'package:http/http.dart' as http;

class AuthenticatedHttpClient {
  AuthenticatedHttpClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Map<String, String> _getRequestHeaders() {
    final authToken = CacheClient().read(key: 'AUTH_TOKEN');

    return {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json'
    };
  }

  Future<http.Response> get(String url) {
    return _httpClient.get(Uri.parse(url), headers: _getRequestHeaders());
  }

  Future<http.Response> post(String url, dynamic data) {
    return _httpClient.post(Uri.parse(url),
        headers: _getRequestHeaders(), body: jsonEncode(data));
  }

  Future<http.Response> delete(String url) {
    return _httpClient.delete(Uri.parse(url), headers: _getRequestHeaders());
  }
}
