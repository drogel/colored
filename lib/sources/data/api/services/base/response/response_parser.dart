import 'package:colored/sources/data/network_client/http_response.dart';

abstract class ResponseParser<T> {
  T? parse(HttpResponse response);
}
