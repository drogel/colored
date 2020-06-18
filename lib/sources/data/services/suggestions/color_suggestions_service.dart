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
  Map<String, String> fetchSuggestions() => _suggestions;

  @override
  Future<void> loadSuggestions() async =>
      _suggestions = await _dataLoader.load();
}
