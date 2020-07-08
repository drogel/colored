import 'dart:convert';

import 'package:colored/resources/mock_data_paths.dart' as mock_paths;
import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/naming/naming_response.dart';
import 'package:colored/sources/data/services/naming/naming_service.dart';
import 'package:colored/sources/domain/data_models/naming_result.dart';
import 'package:flutter/services.dart';

class MockNamingService implements NamingService {
  const MockNamingService();

  @override
  Future<NamingResponse> getNaming({String hexColor}) async {
    final sampleColorStr = await rootBundle.loadString(mock_paths.sampleColor);
    final map = jsonDecode(sampleColorStr);
    final namingMap = map["colors"].first;
    final result = NamingResult.fromMap(namingMap);
    return NamingResponse(result: result, response: ResponseStatus.ok);
  }
}
