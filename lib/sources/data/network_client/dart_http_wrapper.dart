import 'package:colored/sources/data/network_client/http_wrapper.dart';
import 'package:http/http.dart';

class DartHttpWrapper implements HttpWrapper {
  const DartHttpWrapper();

  @override
  Future<Response> get(String url, {Map<String, String> headers}) =>
      get(url, headers: headers);
}
