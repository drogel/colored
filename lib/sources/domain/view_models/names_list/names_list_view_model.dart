import 'dart:async';

import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_state.dart';
import 'package:flutter/foundation.dart';

class NamesListViewModel {
  const NamesListViewModel({
    @required StreamController<NamesListState> stateController,
    @required NamesService namesService,
  })  : assert(stateController != null),
        assert(namesService != null),
        _stateController = stateController,
        _namesService = namesService;

  final StreamController<NamesListState> _stateController;
  final NamesService _namesService;

  Stream<NamesListState> get stateStream => _stateController.stream;

  NamesListState get initialData => const Busy();

  Future<void> init() => _namesService.loadNames();

  void searchColorName(String searchString) {
    final namesMap = _namesService.fetchNamesContaining(searchString);
    final namedColors = namesMap.entries.map(_convertToNamedColor).toList();
    _stateController.sink.add(Found(namedColors));
  }

  void dispose() {
    _stateController.close();
    _namesService.dispose();
  }

  NamedColor _convertToNamedColor(MapEntry<String, String> entry) =>
      NamedColor(name: entry.value, hex: "#${entry.key.toUpperCase()}");
}
