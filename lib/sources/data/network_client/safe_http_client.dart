import 'dart:async';
import 'dart:io';

import 'package:colored/sources/data/network_client/dart_http_wrapper.dart';
import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/network_client/http_response.dart';
import 'package:colored/sources/data/network_client/http_wrapper.dart';
import 'package:colored/sources/data/network_client/response_status.dart';

class SafeHttpClient implements HttpClient {
  const SafeHttpClient({HttpWrapper httpWrapper = const DartHttpWrapper()})
      : assert(httpWrapper != null),
        _httpWrapper = httpWrapper;

  static const timeoutLimitSeconds = 5;
  final HttpWrapper _httpWrapper;

  @override
  Future<HttpResponse> get(String url, {Map<String, String> headers}) async {
    try {
      final response = await _httpWrapper
          .get(url, headers: headers)
          .timeout(const Duration(seconds: timeoutLimitSeconds));
      return HttpResponse(status: ResponseStatus.ok, httpResponse: response);
    } on SocketException catch (_) {
      return const HttpResponse(status: ResponseStatus.failed);
    } on TimeoutException catch (_) {
      return const HttpResponse(status: ResponseStatus.failed);
    }
  }

  @override
  bool isResponseOk(HttpResponse response) =>
      response.status == ResponseStatus.ok &&
      response.httpResponse.statusCode == 200 &&
      response.httpResponse.body != null;
}
