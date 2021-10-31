import 'dart:convert';
import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/api/services/index/api_index/api_index_service.dart';
import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/network_client/response_status.dart';

class ApiIndexFetcher implements ApiIndexService {
  const ApiIndexFetcher({
    required HttpClient client,
    required String apiIndexLink,
  })  : _client = client,
        _apiIndexLink = apiIndexLink;

  final String _apiIndexLink;
  final HttpClient _client;

  @override
  Future<ApiIndex?> fetchApiIndex() async {
    final response = await _client.get(_apiIndexLink);
    final httpResponse = response.httpResponse;
    if (response.status == ResponseStatus.failed || httpResponse == null) {
      return null;
    }

    final apiResponse = ApiResponse.fromJson(jsonDecode(httpResponse.body));
    if (apiResponse == null) {
      return null;
    }

    final apiResponseDataItems = apiResponse.data.items;
    return ApiIndex.fromJsonEntries(apiResponseDataItems);
  }
}
