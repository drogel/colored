import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/api/services/base/response/response_parser.dart';
import 'package:colored/sources/data/api/services/names/base_api_names_service.dart';
import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/domain/data_models/palette.dart';

class PaletteNamesApiService extends BaseApiNamesService<Palette> {
  const PaletteNamesApiService({
    required HttpClient client,
    required ApiIndex? apiIndex,
    required ResponseParser<ApiResponse> parser,
  })  : _apiIndex = apiIndex,
        super(client: client, parser: parser);

  final ApiIndex? _apiIndex;

  @override
  Uri? get baseUri => _apiIndex?.palettes?.search?.names?.endpoint;

  @override
  String get searchQueryKey => Palette.nameKey;

  @override
  Palette parseItemFromJson(Map<String, dynamic> json) =>
      Palette.fromJson(json);
}
