import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/domain/data_models/naming_result.dart';
import 'package:flutter/foundation.dart';

class NamingResponse {
  const NamingResponse({@required this.response, this.result});

  final ResponseStatus response;
  final NamingResult result;
}
