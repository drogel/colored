import 'package:http/http.dart';

abstract class HttpWrapper {
  Future<Response> get(Uri uri, {Map<String, String>? headers});
}
