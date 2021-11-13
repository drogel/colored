import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/pagination/paginator.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';

typedef NamesServiceMapper<O, I> = O Function(MapEntry<String, I> entry);

class BasePaginatedNamesService<O, I> implements PaginatedNamesService<O> {
  const BasePaginatedNamesService({
    required NamesService<I> namesService,
    required Paginator<O> paginator,
    required NamesServiceMapper<O, I> mapper,
  })  : _namesService = namesService,
        _paginator = paginator,
        _mapper = mapper;

  final NamesService<I> _namesService;
  final Paginator<O> _paginator;
  final NamesServiceMapper<O, I> _mapper;

  @override
  Future<ListPage<O>> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async {
    final searchedMap = await _namesService.fetchContainingSearch(searchString);
    final mappedItems = searchedMap.entries.map(_mapper).toList();
    final paginatedItems = _paginator.paginate(
      mappedItems,
      pageInfo: pageInfo,
    );
    return paginatedItems;
  }
}
