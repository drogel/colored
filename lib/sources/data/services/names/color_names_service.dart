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
    filtered.removeWhere((key, value) => !value.contains(searchString));
    return filtered;
  }

  @override
  Future<void> loadNames() async {
    final colorNamesStr = await rootBundle.loadString(paths.colorNames);
    _colorNames = Map<String, String>.from(jsonDecode(colorNamesStr));
  }
}
