import 'dart:async';

import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';

typedef PaginatedNamesSearcher<T> = Future<void> Function(
  String, {
  required List<T> currentItems,
  required PageInfo currentPageInfo,
});

const _kStartIndex = 1;
const _kInitialPageInfo = PageInfo(
  startIndex: _kStartIndex,
  size: 75,
  pageIndex: _kStartIndex,
);

abstract class BaseNamesListViewModel<T> {
  const BaseNamesListViewModel({
    required StreamController<NamesListState> stateController,
    required PaginatedNamesService<T> namesService,
  })  : _stateController = stateController,
        _namesService = namesService;

  final StreamController<NamesListState> _stateController;
  final PaginatedNamesService<T> _namesService;

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
    await _searchColorNamesNextPage(
      searchString,
      pageInfo: nextPageInfo,
      currentItems: currentItems,
    );
  }

  Future<void> startSearch(String searchString) async =>
      _startColorNamesSearch(searchString, pageInfo: _kInitialPageInfo);

  void clearSearch() => _stateController.sink.add(buildInitialState());

  void dispose() => _stateController.close();

  Future<void> _startColorNamesSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async {
    _notifySearchPending(searchString);
    final page = await _namesService.fetchContainingSearch(
      searchString,
      pageInfo: pageInfo,
    );
    if (page == null) {
      return _notifySearchFailed(searchString);
    }
    _notifySearchStarted(searchString, page: page);
  }

  Future<void> _searchColorNamesNextPage(
    String searchString, {
    required PageInfo pageInfo,
    required List<T> currentItems,
  }) async {
    final page = await _namesService.fetchContainingSearch(
      searchString,
      pageInfo: pageInfo,
    );
    if (page == null) {
      return _notifySearchFailed(searchString);
    }
    _notifySearchedNextPage(
      searchString,
      page: page,
      previousItems: currentItems,
    );
  }

  void _notifySearchStarted(
    String searchString, {
    required ListPage<T> page,
  }) {
    final items = page.items;
    if (items.isEmpty) {
      _notifySearchFailed(searchString);
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

  void _notifySearchPending(String searchString) {
    final pendingState = buildSearchPendingState(searchString);
    _stateController.sink.add(pendingState);
  }

  void _notifySearchFailed(String searchString) {
    final failedState = buildSearchFailedState(searchString);
    _stateController.sink.add(failedState);
  }
}
