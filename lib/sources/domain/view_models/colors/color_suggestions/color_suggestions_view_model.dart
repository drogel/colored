import 'dart:async';

import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/color_suggestions_state.dart';
import 'package:flutter/foundation.dart';

const _kSuggestionsLength = 15;

class ColorSuggestionsViewModel {
  const ColorSuggestionsViewModel({
    required StreamController<ColorSuggestionsState> stateController,
    required SuggestionsService<String?> suggestionsService,
  })  : assert(stateController != null),
        assert(suggestionsService != null),
        _stateController = stateController,
        _suggestionsService = suggestionsService;

  final StreamController<ColorSuggestionsState> _stateController;
  final SuggestionsService<String?> _suggestionsService;

  Stream<ColorSuggestionsState> get stateStream => _stateController.stream;

  ColorSuggestionsState get initialState => const Loading();

  Future<void> init() async {
    final map = await _suggestionsService.fetchSuggestions(_kSuggestionsLength);
    final namedColors = map.entries.map(_convertToNamedColor).toList();

    if (namedColors.isEmpty) {
      _stateController.sink.add(const Failed());
    } else {
      _stateController.sink.add(ColorSuggestionsFound(namedColors));
    }
  }

  void dispose() => _stateController.close();

  NamedColor _convertToNamedColor(MapEntry<String, String?> entry) =>
      NamedColor.fromMapEntry(entry);
}
