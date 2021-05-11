import 'dart:async';

import 'package:colored/sources/common/search_configurator/list_search_configurator.dart';
import 'package:colored/sources/common/search_configurator/search_configurator.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_state.dart';

class NamesListViewModel extends ListSearchConfigurator {
  const NamesListViewModel({
    required StreamController<NamesListState> stateController,
    required NamesService namesService,
    required SearchConfigurator searchConfigurator,
  })   : _stateController = stateController,
        _searchConfigurator = searchConfigurator,
        _namesService = namesService;

  final StreamController<NamesListState> _stateController;
  final NamesService _namesService;
  final SearchConfigurator _searchConfigurator;

  Stream<NamesListState> get stateStream => _stateController.stream;

  NamesListState get initialState => Pending.emptySearch();

  Future<void> searchColorNames(String searchString) async {
    final cleanSearch = _searchConfigurator.cleanSearch(searchString);

    if (cleanSearch.length < _searchConfigurator.minSearchLength) {
      return _stateController.sink.add(Pending(search: searchString));
    }

    final namesMap = await _namesService.fetchContainingSearch(cleanSearch);
    final namedColors = namesMap.entries.map(_convertToNamedColor).toList();

    if (namedColors.isEmpty) {
      _stateController.sink.add(NoneFound(search: searchString));
    } else {
      _stateController.sink.add(Found(namedColors, search: searchString));
    }
  }

  void clearSearch() => _stateController.sink.add(Pending.emptySearch());

  void dispose() => _stateController.close();

  NamedColor _convertToNamedColor(MapEntry<String, dynamic> entry) =>
      NamedColor.fromMapEntry(entry);
}
