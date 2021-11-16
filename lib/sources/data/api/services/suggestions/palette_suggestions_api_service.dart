import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/api/services/base/request/base_api_service.dart';
import 'package:colored/sources/data/api/services/base/request/page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/response_parser.dart';
import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/suggestions/paginated_suggestions_service.dart';
import 'package:colored/sources/domain/data_models/palette.dart';

class PaletteSuggestionsApiService extends BaseApiService<Palette>
    implements PaginatedSuggestionsService<Palette> {
  const PaletteSuggestionsApiService({
    required HttpClient client,
    required ApiIndex? apiIndex,
    required PageRequestBuilder pageRequestBuilder,
    required ResponseParser<ApiResponse> parser,
  })  : _apiIndex = apiIndex,
        super(
          client: client,
          pageRequestBuilder: pageRequestBuilder,
          parser: parser,
        );

  final ApiIndex? _apiIndex;

  @override
  Uri? get baseUri => _apiIndex?.suggestions?.palettes?.random?.endpoint;

  @override
  Palette parseItemFromJson(Map<String, dynamic> json) {
    final paletteJson = Map<String, dynamic>.from(
      json[Palette.suggestionMappingKey],
    );
    return Palette.fromJson(paletteJson);
  }

  @override
  Future<ListPage<Palette>?> fetchRandom({
    required PageInfo pageInfo,
  }) async =>
      request([], pageInfo: pageInfo);
}
