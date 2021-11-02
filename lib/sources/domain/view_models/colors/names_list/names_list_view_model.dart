import 'dart:async';

import 'package:colored/sources/common/search_configurator/list_search_configurator.dart';
import 'package:colored/sources/common/search_configurator/search_configurator.dart';
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

  Future<void> searchColorNames(String searchString) async {
    final cleanSearch = _searchConfigurator.cleanSearch(searchString);

    if (cleanSearch.length < _searchConfigurator.minSearchLength) {
      return _stateController.sink.add(Pending(search: searchString));
    }

    const pageInfo = PageInfo(startIndex: 0, size: 30, pageIndex: 0);
    final page = await _namesService.fetchContainingSearch(
      cleanSearch,
      pageInfo: pageInfo,
    );
    final namedColors = page.items;

    if (namedColors.isEmpty) {
      _stateController.sink.add(NoneFound(search: searchString));
    } else {
      _stateController.sink.add(Found(namedColors, search: searchString));
    }
  }

  void clearSearch() => _stateController.sink.add(Pending.emptySearch());

  void dispose() => _stateController.close();
}
