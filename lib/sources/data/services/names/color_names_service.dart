import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:flutter/foundation.dart';

class ColorNamesService implements NamesService {
  ColorNamesService({@required DataLoader dataLoader})
      : assert(dataLoader != null),
        _dataLoader = dataLoader;

  final DataLoader _dataLoader;
  Map<String, String> _colorNames;

  @override
  Map<String, String> fetchNamesContaining(String searchString) {
    if (_colorNames == null) {
      return {};
    }

    final filtered = _filterSearchedNames(searchString);
    return filtered;
  }

  @override
  Future<void> loadNames() async => _colorNames = await _dataLoader.load();

  @override
  void dispose() => _colorNames = null;

  Map<String, String> _filterSearchedNames(String search) {
    final tmpCopy = Map<String, String>.from(_colorNames);
    tmpCopy.removeWhere((hex, name) => _noKeyOrValueFound(hex, name, search));
    return tmpCopy;
  }

  bool _containsSearch(String name, String searchString) =>
      name.toLowerCase().contains(searchString.toLowerCase());

  bool _noKeyOrValueFound(String key, String value, String search) =>
      !_containsSearch(key, search) && !_containsSearch(value, search);
}
