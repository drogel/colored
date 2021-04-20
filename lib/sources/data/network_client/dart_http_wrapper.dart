import 'package:colored/sources/data/network_client/http_wrapper.dart';
import 'package:http/http.dart' as http;

class DartHttpWrapper implements HttpWrapper {
  const DartHttpWrapper();

  @override
  Future<http.Response> get(String url, {Map<String, String> headers}) =>
      http.get(Uri.parse(url), headers: headers);
}
