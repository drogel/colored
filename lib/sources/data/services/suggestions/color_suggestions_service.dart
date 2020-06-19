import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:flutter/foundation.dart';

class ColorSuggestionsService implements SuggestionsService {
  ColorSuggestionsService({@required DataLoader dataLoader})
      : assert(dataLoader != null),
        _dataLoader = dataLoader;

  final DataLoader _dataLoader;
  Map<String, String> _suggestions;

  @override
  void dispose() => _suggestions = null;

  @override
  Map<String, String> fetchRandomSuggestions(int desiredSuggestionsLength) {
    final randomKeys = _getRandomSuggestionKeys(desiredSuggestionsLength);
    final randomSuggestions = {
      for (final key in randomKeys) key: _suggestions[key]
    };
    return randomSuggestions;
  }

  @override
  Future<void> loadSuggestions() async =>
      _suggestions = await _dataLoader.load();

  Iterable<String> _getRandomSuggestionKeys(int desiredLength) sync* {
    final suggestionsKeys = _suggestions.keys.toList();
    final selectedIndexes = _getRandomIntList(
      max: suggestionsKeys.length,
      length: desiredLength,
    );

    for (final index in selectedIndexes) {
      yield suggestionsKeys[index];
    }
  }

  List<int> _getRandomIntList({@required int max, @required int length}) {
    final randomInts = List.generate(max, (i) => i + 1)..shuffle();
    return randomInts.take(length);
  }
}
