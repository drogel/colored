import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpResponse {
  const HttpResponse({
    @required this.status,
    this.httpResponse,
  }) : assert(status != null);

  final http.Response httpResponse;
  final ResponseStatus status;
}
