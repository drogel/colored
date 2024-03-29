import 'package:colored/sources/data/network_client/http_response.dart';

abstract class HttpClient {
  Future<HttpResponse> get(String url, {Map<String, String>? headers});

  Future<HttpResponse> getFromUri(Uri uri, {Map<String, String>? headers});

  bool isResponseOk(HttpResponse response);
}
