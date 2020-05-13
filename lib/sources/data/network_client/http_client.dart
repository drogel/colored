import 'package:colored/sources/data/network_client/network_client.dart';
import 'package:http/http.dart' as http;

class HttpClient implements NetworkClient {
  const HttpClient();

  @override
  Future<http.Response> get(String url, {Map<String, String> headers}) =>
      http.get(url, headers: headers);
}
