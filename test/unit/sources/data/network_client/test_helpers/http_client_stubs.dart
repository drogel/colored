import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/network_client/http_response.dart';
import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:http/http.dart' as http;

class HttpClientSuccessfulStub implements HttpClient {
  const HttpClientSuccessfulStub({
    required String responseBody,
  }) : _responseBody = responseBody;

  final String _responseBody;

  HttpResponse get _stubbedResponse {
    final httpResponse = http.Response(_responseBody, 200);
    return HttpResponse(status: ResponseStatus.ok, httpResponse: httpResponse);
  }

  @override
  Future<HttpResponse> get(String url, {Map<String, String>? headers}) async =>
      _stubbedResponse;

  @override
  Future<HttpResponse> getFromUri(
    Uri uri, {
    Map<String, String>? headers,
  }) async =>
      _stubbedResponse;

  @override
  bool isResponseOk(HttpResponse response) => true;
}

class HttpClientFailingStub implements HttpClient {
  const HttpClientFailingStub();

  @override
  Future<HttpResponse> get(String url, {Map<String, String>? headers}) async =>
      const HttpResponse(status: ResponseStatus.failed);

  @override
  Future<HttpResponse> getFromUri(
    Uri uri, {
    Map<String, String>? headers,
  }) async =>
      const HttpResponse(status: ResponseStatus.failed);

  @override
  bool isResponseOk(HttpResponse response) => false;
}
