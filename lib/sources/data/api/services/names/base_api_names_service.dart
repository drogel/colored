import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/api/services/base/request/base_api_service.dart';
import 'package:colored/sources/data/api/services/base/request/page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/response_parser.dart';
import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';

abstract class BaseApiNamesService<O> extends BaseApiService<O>
    implements PaginatedNamesService<O> {
  const BaseApiNamesService({
    required HttpClient client,
    required PageRequestBuilder pageRequestBuilder,
    required ResponseParser<ApiResponse> parser,
  }) : super(
          client: client,
          pageRequestBuilder: pageRequestBuilder,
          parser: parser,
        );

  @override
  Uri? get baseUri;

  @override
  O parseItemFromJson(Map<String, dynamic> json);

  @override
  Future<ListPage<O>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async =>
      request([searchString], pageInfo: pageInfo);
}
