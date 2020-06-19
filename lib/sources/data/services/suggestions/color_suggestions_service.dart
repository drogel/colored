import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/random_generator/random_generator.dart';
import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:flutter/foundation.dart';

class ColorSuggestionsService implements SuggestionsService {
  ColorSuggestionsService({
    @required DataLoader dataLoader,
    @required RandomGenerator randomGenerator,
  })  : assert(dataLoader != null),
        assert(randomGenerator != null),
        _dataLoader = dataLoader,
        _randomGenerator = randomGenerator;

  final DataLoader _dataLoader;
  final RandomGenerator _randomGenerator;
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
    final selectedIndexes = _randomGenerator.getList(
      max: suggestionsKeys.length,
      length: desiredLength,
    );

    for (final index in selectedIndexes) {
      yield suggestionsKeys[index];
    }
  }
}
