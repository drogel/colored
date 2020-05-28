import 'dart:convert';

import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ColorNamesService implements NamesService {
  Map<String, String> _colorNames;

  @override
  Future<Map<String, String>> fetchNamesContaining(String search) async {
    if (_colorNames == null) {
      return {};
    }

    final filtered = await compute<_ColorNamesSearchData, Map<String, String>>(
      _filterSearchedNames,
      _ColorNamesSearchData(search, _colorNames),
    );
    return filtered;
  }

  @override
  Future<void> loadNames() async {
    final colorNamesStr = await rootBundle.loadString(paths.colorNames);
    _colorNames = Map<String, String>.from(jsonDecode(colorNamesStr));
  }

  @override
  void dispose() => _colorNames = null;
}

class _ColorNamesSearchData {
  const _ColorNamesSearchData(this.search, this.colorNames);

  final String search;
  final Map<String, String> colorNames;
}

Map<String, String> _filterSearchedNames(_ColorNamesSearchData searchData) =>
    Map<String, String>.from(searchData.colorNames)
      ..removeWhere((_, name) => !_containsSearch(name, searchData.search));

bool _containsSearch(String name, String searchString) =>
    name.toLowerCase().contains(searchString.toLowerCase());
