import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';

class SuggestionsSearchApiService<T> implements PaginatedNamesService<T> {
  SuggestionsSearchApiService({
    required PaginatedNamesService<T> namesService,
    int searchLengthTrigger = 2,
  })  : assert(searchLengthTrigger > 1),
        _searchLengthTrigger = searchLengthTrigger,
        _namesService = namesService;

  final PaginatedNamesService<T> _namesService;
  final int _searchLengthTrigger;
  String _lastSearchStart = "";
  ListPage<T>? _lastListPage;

  @override
  Future<ListPage<T>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async {
    if (searchString.length < _searchLengthTrigger) {
      return _lastListPage;
    }
    final searchStart = searchString.substring(0, _searchLengthTrigger);
    if (_lastSearchStart == searchStart) {
      return _lastListPage;
    }
    _lastSearchStart = searchStart;
    final listPage = await _namesService.fetchContainingSearch(
      _lastSearchStart,
      pageInfo: pageInfo,
    );
    _lastListPage = listPage;
    return listPage;
  }
}
