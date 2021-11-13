import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/api/services/base/request/page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/response_parser.dart';
import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';

abstract class BaseApiNamesService<O> implements PaginatedNamesService<O> {
  const BaseApiNamesService({
    required HttpClient client,
    required PageRequestBuilder pageRequestBuilder,
    required ResponseParser<ApiResponse> parser,
  })  : _client = client,
        _pageRequestBuilder = pageRequestBuilder,
        _parser = parser;

  final HttpClient _client;
  final PageRequestBuilder _pageRequestBuilder;
  final ResponseParser<ApiResponse> _parser;

  Uri? get baseUri;
  String get searchQueryKey;

  O parseItemFromJson(Map<String, dynamic> json);

  @override
  Future<ListPage<O>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async {
    final endpointUri = _buildSearchUri(searchString, pageInfo: pageInfo);
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

  Uri? _buildSearchUri(String searchString, {required PageInfo pageInfo}) {
    final uri = baseUri;
    if (uri == null) {
      return null;
    }
    final nameRequestQueryParameter = uri.queryParameters.entries.first;
    final searchUri = uri.replace(queryParameters: {
      nameRequestQueryParameter.key: searchString,
    });
    return _pageRequestBuilder.addPageParameters(searchUri, pageInfo: pageInfo);
  }
}
