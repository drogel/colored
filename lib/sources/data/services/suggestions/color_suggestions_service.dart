import 'package:colored/sources/data/services/list_picker/list_picker.dart';
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:flutter/foundation.dart';

class ColorSuggestionsService implements SuggestionsService {
  ColorSuggestionsService({
    @required DataLoader dataLoader,
    @required ListPicker<String> listPicker,
  })  : assert(dataLoader != null),
        assert(listPicker != null),
        _dataLoader = dataLoader,
        _listPicker = listPicker;

  final DataLoader _dataLoader;
  final ListPicker<String> _listPicker;
  Map<String, String> _suggestions;

  @override
  void dispose() => _suggestions = null;

  @override
  Map<String, String> fetchRandomSuggestions(int estimatedCount) {
    final keys = _suggestions.keys.toList();
    final chosenKeys = _listPicker.pick(from: keys, count: estimatedCount);
    final randomSuggestions = {
      for (final key in chosenKeys) key: _suggestions[key]
    };
    return randomSuggestions;
  }

  @override
  Future<void> loadSuggestions() async =>
      _suggestions = await _dataLoader.load();
}
