import 'dart:convert';

import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/api/services/base/response/response_parser.dart';
import 'package:colored/sources/data/network_client/http_response.dart';
import 'package:colored/sources/data/network_client/response_status.dart';

class ApiResponseParser implements ResponseParser<ApiResponse> {
  const ApiResponseParser();

  @override
  ApiResponse? parse(HttpResponse response) {
    final httpResponse = response.httpResponse;
    if (response.status == ResponseStatus.failed || httpResponse == null) {
      return null;
    }
    final responseJsonStr = utf8.decode(httpResponse.bodyBytes);
    return ApiResponse.fromJson(json.decode(responseJsonStr));
  }
}
