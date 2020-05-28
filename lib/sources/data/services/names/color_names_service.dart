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

  bool _containsSearch(String name, String searchString) =>
      name.toLowerCase().contains(searchString.toLowerCase());

  Map<String, String> _filterSearchedNames(String searchString) =>
      Map<String, String>.from(_colorNames)
        ..removeWhere((_, name) => !_containsSearch(name, searchString));
}
