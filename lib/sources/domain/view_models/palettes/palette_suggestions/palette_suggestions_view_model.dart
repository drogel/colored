import 'dart:async';

import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_state.dart';
import 'package:flutter/foundation.dart';

const _kSuggestionsLength = 15;

class PaletteSuggestionsViewModel {
  const PaletteSuggestionsViewModel({
    @required StreamController<PaletteSuggestionsState> stateController,
    @required SuggestionsService<List<String>> suggestionsService,
  })  : assert(stateController != null),
        assert(suggestionsService != null),
        _stateController = stateController,
        _suggestionsService = suggestionsService;

  final StreamController<PaletteSuggestionsState> _stateController;
  final SuggestionsService<List<String>> _suggestionsService;

  Stream<PaletteSuggestionsState> get stateStream => _stateController.stream;

  PaletteSuggestionsState get initialState => const Loading();

  Future<void> init() async {
    final map = await _suggestionsService.fetchSuggestions(_kSuggestionsLength);
    final palettes = map.entries.map(_convertToPalette).toList();

    if (palettes.isEmpty) {
      _stateController.sink.add(const Failed());
    } else {
      _stateController.sink.add(PaletteSuggestionsFound(palettes));
    }
  }

  void dispose() => _stateController.close();

  Palette _convertToPalette(MapEntry<String, List<String>> entry) =>
      Palette.fromMapEntry(entry);
}
