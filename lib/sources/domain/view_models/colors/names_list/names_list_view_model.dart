import 'dart:async';

import 'package:colored/sources/common/search_configurator/list_search_configurator.dart';
import 'package:colored/sources/common/search_configurator/search_configurator.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_state.dart';

class NamesListViewModel extends ListSearchConfigurator {
  const NamesListViewModel({
    required StreamController<NamesListState> stateController,
    required PaginatedNamesService<NamedColor> namesService,
    required SearchConfigurator searchConfigurator,
  })  : _stateController = stateController,
        _searchConfigurator = searchConfigurator,
        _namesService = namesService;

  final StreamController<NamesListState> _stateController;
  final PaginatedNamesService<NamedColor> _namesService;
  final SearchConfigurator _searchConfigurator;

  Stream<NamesListState> get stateStream => _stateController.stream;

  NamesListState get initialState => Pending.emptySearch();

  Future<void> searchColorNamesNextPage(
    String searchString, {
    required List<NamedColor> currentNamedColors,
    required PageInfo currentPageInfo,
  }) async {
    final nextPageInfo = currentPageInfo.next;
    await _searchColorNames(
      searchString,
      pageInfo: nextPageInfo,
      currentNamedColors: currentNamedColors,
    );
  }

  Future<void> startColorNamesSearch(String searchString) async {
    const startIndex = 1;
    const initialPageInfo = PageInfo(
      startIndex: startIndex,
      size: 60,
      pageIndex: startIndex,
    );
    await _searchColorNames(searchString, pageInfo: initialPageInfo);
  }

  void clearSearch() => startColorNamesSearch("");

  void dispose() => _stateController.close();

  Future<void> _searchColorNames(
    String searchString, {
    required PageInfo pageInfo,
    List<NamedColor>? currentNamedColors,
  }) async {
    final cleanSearch = _searchConfigurator.cleanSearch(searchString);

    if (cleanSearch.length < _searchConfigurator.minSearchLength) {
      return _stateController.sink.add(Pending(search: searchString));
    }

    final page = await _namesService.fetchContainingSearch(
      cleanSearch,
      pageInfo: pageInfo,
    );
    if (currentNamedColors == null || currentNamedColors.isEmpty) {
      _notifySearchStarted(searchString, page: page);
    } else {
      _notifySearchedNextPage(
        searchString,
        page: page,
        previousNamedColors: currentNamedColors,
      );
    }
  }

  void _notifySearchStarted(
    String searchString, {
    required ListPage<NamedColor> page,
  }) {
    final namedColors = page.items;
    if (namedColors.isEmpty) {
      _stateController.sink.add(NoneFound(search: searchString));
    } else {
      _stateController.sink.add(
        Found(namedColors, search: searchString, pageInfo: page.pageInfo),
      );
    }
  }

  void _notifySearchedNextPage(
    String searchString, {
    required ListPage<NamedColor> page,
    required List<NamedColor> previousNamedColors,
  }) {
    final allNamedColors = previousNamedColors + page.items;
    _stateController.sink.add(
      Found(allNamedColors, search: searchString, pageInfo: page.pageInfo),
    );
  }
}
