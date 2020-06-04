import 'dart:async';
import 'dart:io';

import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:http/http.dart' as http;

const _kTimeoutLimit = 5;

class SafeHttpClient implements HttpClient {
  const SafeHttpClient();

  @override
  Future<http.Response> get(String url, {Map<String, String> headers}) async {
    try {
      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: _kTimeoutLimit));
      return response;
    } on SocketException catch (_) {
      return null;
    } on TimeoutException catch (_) {
      return null;
    }
  }
}
