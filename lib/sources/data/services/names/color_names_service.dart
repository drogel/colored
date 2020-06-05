import 'dart:convert';

import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:flutter/services.dart';

class ColorNamesService implements NamesService {
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
  Future<void> loadNames() async {
    final colorNamesStr = await rootBundle.loadString(paths.colorNames);
    _colorNames = Map<String, String>.from(jsonDecode(colorNamesStr));
  }

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
