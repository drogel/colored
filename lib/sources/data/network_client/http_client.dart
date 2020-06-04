import 'package:http/http.dart' as http;

abstract class HttpClient {
  Future<http.Response> get(String url, {Map<String, String> headers});
}
