import 'package:colored/sources/common/extensions/string_clean_hex_string.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';

class NamesListApiService implements PaginatedNamesService<NamedColor> {
  const NamesListApiService({
    required PaginatedNamesService<NamedColor> colorNamesApiService,
    required PaginatedNamesService<NamedColor> colorHexesApiService,
  })  : _colorNamesApiService = colorNamesApiService,
        _colorHexesApiService = colorHexesApiService;

  final PaginatedNamesService<NamedColor> _colorNamesApiService;
  final PaginatedNamesService<NamedColor> _colorHexesApiService;

  @override
  Future<ListPage<NamedColor>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) {
    final searchHexRegExp = RegExp(r'^#?([0-9a-fA-F]{6})$');
    if (searchHexRegExp.hasMatch(searchString)) {
      final cleanHex = searchString.cleanHex;
      return _colorHexesApiService.fetchContainingSearch(
        cleanHex,
        pageInfo: pageInfo,
      );
    } else {
      return _colorNamesApiService.fetchContainingSearch(
        searchString,
        pageInfo: pageInfo,
      );
    }
  }
}
