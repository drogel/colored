import 'dart:convert';

import 'package:colored/sources/data/api_endpoints.dart' as endpoints;
import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_response.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_service.dart';
import 'package:colored/sources/data/services/url_composer/url_composer.dart';
import 'package:colored/sources/domain/data_models/naming_result.dart';

class MeodaiPaletteNamingService implements PaletteNamingService {
  const MeodaiPaletteNamingService({
    required UrlComposer urlComposer,
    required HttpClient networkClient,
  })   : _client = networkClient,
        _urlComposer = urlComposer;

  final UrlComposer _urlComposer;
  final HttpClient _client;

  @override
  Future<PaletteNamingResponse> getNaming({
    required List<String> hexColors,
  }) async {
    if (hexColors.isEmpty) {
      return const PaletteNamingResponse(ResponseStatus.failed);
    }

    final hexColorsPath = hexColors.join();
    final url = _urlComposer.compose(endpoints.baseUrl, path: hexColorsPath);
    final response = await _client.get(url);
    final httpResponse = response.httpResponse;
    if (!_client.isResponseOk(response) || httpResponse == null) {
      return const PaletteNamingResponse(ResponseStatus.failed);
    }

    final map = jsonDecode(httpResponse.body);
    final paletteMapList = map[NamingResult.mappingKey];
    final palettes = List<Map<String, dynamic>>.from(paletteMapList);
    final results = palettes.map((map) => NamingResult.fromMap(map)).toList();
    return PaletteNamingResponse(ResponseStatus.ok, results: results);
  }
}
