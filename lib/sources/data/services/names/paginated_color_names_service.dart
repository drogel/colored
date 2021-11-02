import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/paginator.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';

class PaginatedColorNamesService implements PaginatedNamesService<NamedColor> {
  const PaginatedColorNamesService({
    required NamesService<String> namesService,
    required Paginator<NamedColor> paginator,
  })  : _namesService = namesService,
        _paginator = paginator;

  final NamesService<String> _namesService;
  final Paginator<NamedColor> _paginator;

  @override
  Future<ListPage<NamedColor>> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async {
    final namesMap = await _namesService.fetchContainingSearch(searchString);
    final namedColors = namesMap.entries.map(_convertToNamedColor).toList();
    final pagedNamedColors = _paginator.paginate(
      namedColors,
      pageInfo: pageInfo,
    );
    return pagedNamedColors;
  }

  NamedColor _convertToNamedColor(MapEntry<String, dynamic> entry) =>
      NamedColor.fromMapEntry(entry);
}
