import 'dart:convert';

import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:flutter/services.dart';

class ColorNamesService implements NamesService {
  Set<String> _colorNames;

  @override
  List<String> fetchNamesContaining(String searchString) {
    final filtered = _colorNames.where((name) => name == searchString).toList();
    filtered.sort((a, b) => a.compareTo(b));
    return filtered;
  }

  @override
  Future<void> loadNames() async {
    final colorNamesStr = await rootBundle.loadString(paths.colorNames);
    final Map<String, dynamic> colorNamesMap = jsonDecode(colorNamesStr);
    _colorNames = colorNamesMap.values.toSet();
  }
}
