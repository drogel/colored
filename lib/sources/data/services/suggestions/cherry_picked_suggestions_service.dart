import 'package:colored/sources/data/services/list_picker/list_picker.dart';
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:flutter/foundation.dart';

class CherryPickedSuggestionsService<T> implements SuggestionsService<T> {
  CherryPickedSuggestionsService({
    @required DataLoader dataLoader,
    @required ListPicker<String> listPicker,
  })  : assert(dataLoader != null),
        assert(listPicker != null),
        _dataLoader = dataLoader,
        _listPicker = listPicker;

  final DataLoader _dataLoader;
  final ListPicker<String> _listPicker;

  @override
  Future<Map<String, T>> fetchSuggestions(int estimatedCount) async {
    final suggestions = await _dataLoader.load();
    final keys = suggestions.keys.toList();
    final chosenKeys = _listPicker.pick(from: keys, count: estimatedCount);
    final chosenSuggestions = <String, T>{
      for (final key in chosenKeys) key: suggestions[key]
    };
    return chosenSuggestions;
  }
}
