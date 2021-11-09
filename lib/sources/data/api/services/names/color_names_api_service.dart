import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/api/services/base/response/response_parser.dart';
import 'package:colored/sources/data/api/services/names/base_api_names_service.dart';
import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/common/extensions/uri_copy.dart';

class ColorNamesApiService extends BaseApiNamesService<NamedColor> {
  const ColorNamesApiService({
    required HttpClient client,
    required ApiIndex? apiIndex,
    required ResponseParser<ApiResponse> parser,
  })  : _apiIndex = apiIndex,
        super(client: client, parser: parser);

  final ApiIndex? _apiIndex;

  @override
  NamedColor parseItemFromJson(Map<String, dynamic> json) =>
      NamedColor.fromJson(json);

  @override
  Uri? buildSearchUri(String searchString, {required PageInfo pageInfo}) {
    final endpointUri = _apiIndex?.colors?.search?.names?.endpoint;
    if (endpointUri == null) {
      return null;
    }
    final requestQueryParameters = {
      NamedColor.nameKey: searchString,
      PageInfo.sizeKey: pageInfo.size.toString(),
      PageInfo.pageIndexKey: pageInfo.pageIndex.toString(),
    };
    final uri = endpointUri.copy(queryParameters: requestQueryParameters);
    return uri;
  }
}
