import 'dart:convert';

import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_response.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_service.dart';
import 'package:colored/resources/mock_data_paths.dart' as mock_paths;
import 'package:colored/sources/domain/data_models/naming_result.dart';
import 'package:flutter/services.dart';

class MockPaletteNamingService implements PaletteNamingService {
  const MockPaletteNamingService();

  @override
  Future<PaletteNamingResponse> getNaming({List<String> hexColors}) async {
    final samplePalette = await rootBundle.loadString(mock_paths.samplePalette);
    final jsonResponse = jsonDecode(samplePalette);
    final mapList = jsonResponse[NamingResult.mappingKey];
    final paletteMap = List<Map<String, dynamic>>.from(mapList);
    final results = paletteMap.map((map) => NamingResult.fromMap(map)).toList();
    return PaletteNamingResponse(ResponseStatus.ok, results: results);
  }
}
