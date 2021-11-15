import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/api/services/base/request/api_request_builder.dart';
import 'package:colored/sources/data/api/services/base/request/page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/response_parser.dart';
import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';

abstract class BaseApiService<T> implements ApiRequestBuilder<T> {
  const BaseApiService({
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

  T parseItemFromJson(Map<String, dynamic> json);

  @override
  Future<ListPage<T>?> request(
    Iterable<String> queryParameters, {
    required PageInfo pageInfo,
  }) async {
    final endpointUri = _buildSearchUri(queryParameters, pageInfo: pageInfo);
    if (endpointUri == null) {
      return null;
    }
    final response = await _client.getFromUri(endpointUri);
    final apiResponse = _parser.parse(response);
    if (apiResponse == null) {
      return null;
    }
    final listPage = ListPage<T>.fromApiResponseData(
      apiResponse.data,
      jsonParser: parseItemFromJson,
    );
    return listPage;
  }

  Uri? _buildSearchUri(
    Iterable<String> queryParameters, {
    required PageInfo pageInfo,
  }) {
    final uri = baseUri;
    if (uri == null) {
      return null;
    }
    final searchUri = _buildUriParameters(uri, queryParameters);
    return _pageRequestBuilder.addPageParameters(searchUri, pageInfo: pageInfo);
  }

  Uri _buildUriParameters(Uri uri, Iterable<String> queryParameters) {
    if (uri.queryParameters.isEmpty) {
      return uri;
    }
    final requestQueryParameter = uri.queryParameters.entries.first;
    return uri.replace(queryParameters: {
      requestQueryParameter.key: queryParameters,
    });
  }
}
