import 'dart:async';

import 'package:colored/sources/data/services/suggestions/color_suggestions_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_state.dart';
import 'package:flutter/foundation.dart';

const _kSuggestionsLength = 20;

class ColorSuggestionsViewModel {
  const ColorSuggestionsViewModel({
    @required StreamController<ColorSuggestionsState> stateController,
    @required ColorSuggestionsService suggestionsService,
  })  : assert(stateController != null),
        assert(suggestionsService != null),
        _stateController = stateController,
        _suggestionsService = suggestionsService;

  final StreamController<ColorSuggestionsState> _stateController;
  final ColorSuggestionsService _suggestionsService;

  Stream<ColorSuggestionsState> get stateStream => _stateController.stream;

  ColorSuggestionsState get initialData => const Loading();

  Future<void> init() async {
    await _suggestionsService.loadSuggestions();

    final map = _suggestionsService.fetchRandomSuggestions(_kSuggestionsLength);
    final namedColors = map.entries.map(_convertToNamedColor).toList();

    if (namedColors.isEmpty) {
      _stateController.sink.add(const Failed());
    } else {
      _stateController.sink.add(Found(namedColors));
    }
  }

  void dispose() {
    _suggestionsService.dispose();
    _stateController.close();
  }

  NamedColor _convertToNamedColor(MapEntry<String, String> entry) =>
      NamedColor(name: entry.value, hex: "#${entry.key.toUpperCase()}");
}
