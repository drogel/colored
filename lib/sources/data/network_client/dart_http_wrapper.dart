import 'package:colored/sources/data/network_client/http_wrapper.dart';
import 'package:http/http.dart' as http;

class DartHttpWrapper implements HttpWrapper {
  const DartHttpWrapper();

  @override
  Future<http.Response> get(Uri uri, {Map<String, String>? headers}) =>
      http.get(uri, headers: headers);
}
