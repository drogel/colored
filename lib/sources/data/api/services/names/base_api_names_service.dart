import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/api/services/base/response/response_parser.dart';
import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';

abstract class BaseApiNamesService<O> implements PaginatedNamesService<O> {
  const BaseApiNamesService({
    required HttpClient client,
    required Uri? endpointUri,
    required ResponseParser<ApiResponse> parser,
  })  : _client = client,
        _endpointUri = endpointUri,
        _parser = parser;

  final Uri? _endpointUri;
  final HttpClient _client;
  final ResponseParser<ApiResponse> _parser;

  @override
  Future<ListPage<O>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async {
    final endpointUri = _endpointUri;
    if (endpointUri == null) {
      return null;
    }
    final response = await _client.getFromUri(endpointUri);
    final apiResponse = _parser.parse(response);
    if (apiResponse == null) {
      return null;
    }
    final listPage = ListPage<O>.fromApiResponseData(
      apiResponse.data,
      jsonParser: parseItemFromJson,
    );
    return listPage;
  }

  O parseItemFromJson(Map<String, dynamic> json);
}
