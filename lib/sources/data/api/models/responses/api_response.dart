import 'package:colored/sources/common/extensions/map_safe_access.dart';
import 'package:colored/sources/data/api/models/responses/api_response_data.dart';
import 'package:colored/sources/data/network_client/http_method.dart';

class ApiResponse {
  const ApiResponse({
    required this.apiVersion,
    required this.method,
    required this.data,
  });

  static ApiResponse? fromJson(Map<String, dynamic> json) {
    final apiVersion = json.valueFor<String>(_Key.apiVersion.value);
    final methodString = json.stringValueFor(_Key.method.value);
    final method = httpMethodFromString(methodString);
    final dataMap = json.valueFor<Map<String, dynamic>>(_Key.data.value);
    if (dataMap == null || apiVersion == null) {
      return null;
    }
    final data = ApiResponseData.fromJson(dataMap);
    if (data == null) {
      return null;
    }
    return ApiResponse(apiVersion: apiVersion, method: method, data: data);
  }

  final String apiVersion;
  final HttpMethod method;
  final ApiResponseData data;
}

enum _Key {
  apiVersion,
  method,
  data,
}

extension _KeyValues on _Key {
  String get value {
    switch (this) {
      case _Key.apiVersion:
        return "apiVersion";
      case _Key.method:
        return "method";
      case _Key.data:
        return "data";
    }
  }
}
