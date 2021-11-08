import 'dart:async';

import 'package:colored/sources/common/search_configurator/search_configurator.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';

typedef PaginatedNamesSearcher<T> = Future<void> Function(
  String, {
  required List<T> currentItems,
  required PageInfo currentPageInfo,
});

abstract class BaseNamesListViewModel<T> {
  const BaseNamesListViewModel({
    required StreamController<NamesListState> stateController,
    required PaginatedNamesService<T> namesService,
    required SearchConfigurator searchConfigurator,
  })  : _stateController = stateController,
        _searchConfigurator = searchConfigurator,
        _namesService = namesService;

  final StreamController<NamesListState> _stateController;
  final PaginatedNamesService<T> _namesService;
  final SearchConfigurator _searchConfigurator;

  NamesListState buildInitialState();

  NamesListState buildSearchPendingState(String searchString);

  NamesListState buildSearchFailedState(String searchString);

  NamesListState buildSearchSuccessState(
    String searchString, {
    required PageInfo pageInfo,
    required List<T> items,
  });

  Stream<NamesListState> get stateStream => _stateController.stream;

  NamesListState get initialState => buildInitialState();

  Future<void> searchNextPage(
    String searchString, {
    required List<T> currentItems,
    required PageInfo currentPageInfo,
  }) async {
    final nextPageInfo = currentPageInfo.next;
    await _searchColorNames(
      searchString,
      pageInfo: nextPageInfo,
      currentItems: currentItems,
    );
  }

  Future<void> startSearch(String searchString) async {
    const startIndex = 1;
    const initialPageInfo = PageInfo(
      startIndex: startIndex,
      size: 60,
      pageIndex: startIndex,
    );
    await _searchColorNames(searchString, pageInfo: initialPageInfo);
  }

  void clearSearch() => startSearch("");

  void dispose() => _stateController.close();

  Future<void> _searchColorNames(
    String searchString, {
    required PageInfo pageInfo,
    List<T>? currentItems,
  }) async {
    final cleanSearch = _searchConfigurator.cleanSearch(searchString);

    if (cleanSearch.length < _searchConfigurator.minSearchLength) {
      final pendingState = buildSearchPendingState(searchString);
      return _stateController.sink.add(pendingState);
    }

    final page = await _namesService.fetchContainingSearch(
      cleanSearch,
      pageInfo: pageInfo,
    );
    if (currentItems == null || currentItems.isEmpty) {
      _notifySearchStarted(searchString, page: page);
    } else {
      _notifySearchedNextPage(
        searchString,
        page: page,
        previousItems: currentItems,
      );
    }
  }

  void _notifySearchStarted(
    String searchString, {
    required ListPage<T> page,
  }) {
    final items = page.items;
    if (items.isEmpty) {
      final failedState = buildSearchFailedState(searchString);
      _stateController.sink.add(failedState);
    } else {
      final state = buildSearchSuccessState(
        searchString,
        pageInfo: page.pageInfo,
        items: items,
      );
      _stateController.sink.add(state);
    }
  }

  void _notifySearchedNextPage(
    String searchString, {
    required ListPage<T> page,
    required List<T> previousItems,
  }) {
    final allItems = previousItems + page.items;
    final state = buildSearchSuccessState(
      searchString,
      pageInfo: page.pageInfo,
      items: allItems,
    );
    _stateController.sink.add(state);
  }
}
