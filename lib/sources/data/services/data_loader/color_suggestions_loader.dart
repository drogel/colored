import 'dart:convert';

import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:flutter/services.dart';

class ColorSuggestionsLoader implements DataLoader<String> {
  const ColorSuggestionsLoader();

  @override
  Future<Map<String, String>> load() async {
    final colorNamesStr = await rootBundle.loadString(paths.colorSuggestions);
    return Map<String, String>.from(jsonDecode(colorNamesStr));
  }
}
