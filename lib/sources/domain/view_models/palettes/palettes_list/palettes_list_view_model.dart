import 'dart:async';

import 'package:colored/sources/common/search_configurator/search_configurator.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_state.dart';

class PalettesListViewModel {
  const PalettesListViewModel({
    required StreamController<PalettesListState> stateController,
    required NamesService<List<String>> namesService,
    required SearchConfigurator searchConfigurator,
  })   : _stateController = stateController,
        _namesService = namesService,
        _searchConfigurator = searchConfigurator;

  final SearchConfigurator _searchConfigurator;
  final StreamController<PalettesListState> _stateController;
  final NamesService<List<String>> _namesService;

  Stream<PalettesListState> get stateStream => _stateController.stream;

  PalettesListState get initialState => Pending.emptySearch();

  Future<void> searchPalettes(String searchString) async {
    final cleanSearch = _searchConfigurator.cleanSearch(searchString);

    if (cleanSearch.length < _searchConfigurator.minSearchLength) {
      return _stateController.sink.add(Pending(search: searchString));
    }

    final palettesMap = await _namesService.fetchContainingSearch(cleanSearch);
    final palettes = _convertToPalettes(palettesMap);

    if (palettes.isEmpty) {
      _stateController.sink.add(NoneFound(search: searchString));
    } else {
      _stateController.sink.add(Found(palettes, search: searchString));
    }
  }

  void clearSearch() => _stateController.sink.add(Pending.emptySearch());

  void dispose() => _stateController.close();

  List<Palette> _convertToPalettes(Map<String, List<String>> palettesMap) =>
      palettesMap.entries.map((entry) => Palette.fromMapEntry(entry)).toList();
}
