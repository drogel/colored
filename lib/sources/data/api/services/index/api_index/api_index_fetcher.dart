import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/api/services/base/response/response_parser.dart';
import 'package:colored/sources/data/api/services/index/api_index/api_index_service.dart';
import 'package:colored/sources/data/network_client/http_client.dart';

class ApiIndexFetcher implements ApiIndexService {
  const ApiIndexFetcher({
    required HttpClient client,
    required String apiIndexLink,
    required ResponseParser<ApiResponse> parser,
  })  : _client = client,
        _apiIndexLink = apiIndexLink,
        _parser = parser;

  final String _apiIndexLink;
  final HttpClient _client;
  final ResponseParser<ApiResponse> _parser;

  @override
  Future<ApiIndex?> fetchApiIndex() async {
    final response = await _client.get(_apiIndexLink);
    final apiResponse = _parser.parse(response);
    if (apiResponse == null) {
      return null;
    }

    final apiResponseDataItems = apiResponse.data.items;
    return ApiIndex.fromJsonEntries(apiResponseDataItems);
  }
}
