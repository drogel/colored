import 'package:http/http.dart';

abstract class HttpWrapper {
  Future<Response> get(String url, {Map<String, String> headers});
}