import 'package:colored/sources/data/services/api_response.dart';
import 'package:colored/sources/domain/data_models/naming_result.dart';
import 'package:flutter/foundation.dart';

class NamingResponse {
  const NamingResponse({@required this.response, this.result});

  final ApiResponse response;
  final NamingResult result;
}
