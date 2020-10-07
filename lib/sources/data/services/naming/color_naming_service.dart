import 'dart:convert';

import 'package:colored/sources/data/api_endpoints.dart' as endpoints;
import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/naming/naming_response.dart';
import 'package:colored/sources/data/services/naming/naming_service.dart';
import 'package:colored/sources/data/services/url_composer/url_composer.dart';
import 'package:colored/sources/domain/data_models/naming_result.dart';
import 'package:flutter/foundation.dart';

class ColorNamingService implements NamingService {
  const ColorNamingService({
    @required UrlComposer urlComposer,
    @required HttpClient networkClient,
  })  : assert(urlComposer != null),
        assert(networkClient != null),
        _client = networkClient,
        _urlComposer = urlComposer;

  final UrlComposer _urlComposer;
  final HttpClient _client;

  @override
  Future<NamingResponse> getNaming({String hexColor}) async {
    final url = _urlComposer.compose(endpoints.baseUrl, path: hexColor);
    final response = await _client.get(url);
    if (!_client.isResponseOk(response)) {
      return const NamingResponse(ResponseStatus.failed);
    }

    final map = jsonDecode(response.httpResponse.body);
    final namingMap = map[NamingResult.mappingKey].first;
    final result = NamingResult.fromMap(namingMap);
    return NamingResponse(ResponseStatus.ok, result: result);
  }
}
