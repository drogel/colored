import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:flutter/foundation.dart';

class ColorNamesService implements NamesService {
  ColorNamesService({@required DataLoader dataLoader})
      : assert(dataLoader != null),
        _dataLoader = dataLoader;

  final DataLoader _dataLoader;

  @override
  Future<Map<String, String>> fetchNamesContaining(String searchString) async {
    final colorNames = await _dataLoader.load();
    final filteredColorNames = _filterSearchedNames(searchString, colorNames);
    return filteredColorNames;
  }

  Map<String, String> _filterSearchedNames(
    String search,
    Map<String, String> colorNames,
  ) {
    final tmpCopy = Map<String, String>.from(colorNames);
    tmpCopy.removeWhere((hex, name) => _noKeyOrValueFound(hex, name, search));
    return tmpCopy;
  }

  bool _containsSearch(String name, String searchString) =>
      name.toLowerCase().contains(searchString.toLowerCase());

  bool _noKeyOrValueFound(String key, String value, String search) =>
      !_containsSearch(key, search) && !_containsSearch(value, search);
}
