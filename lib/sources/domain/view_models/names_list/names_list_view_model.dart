import 'dart:async';

import 'package:colored/sources/common/extensions/string_replace_non_alphanumeric.dart';
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

  NamesListState get initialState => Pending.emptySearch();

  Future<void> searchColorName(String searchString) async {
    final cleanSearch = _cleanSearch(searchString);

    if (cleanSearch.length < 3) {
      return _stateController.sink.add(Pending(search: searchString));
    }

    final namesMap = await _namesService.fetchNamesContaining(cleanSearch);
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

  String _cleanSearch(String searchString) => searchString
      .trimLeft()
      .replacingAllNonAlphanumericBy("")
      .replaceAll("#", "");
}
