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

    final filtered = _colorNames;
    filtered.removeWhere((_, name) => !_containsSearch(name, searchString));
    return filtered;
  }

  @override
  Future<void> loadNames() async {
    final colorNamesStr = await rootBundle.loadString(paths.colorNames);
    _colorNames = Map<String, String>.from(jsonDecode(colorNamesStr));
  }

  @override
  void dispose() => _colorNames = null;

  bool _containsSearch(String hexColor, String searchString) =>
      hexColor.toLowerCase().contains(searchString.toLowerCase());
}
