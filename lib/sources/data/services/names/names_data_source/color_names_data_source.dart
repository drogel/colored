import 'dart:convert';

import 'package:colored/sources/data/services/names/names_data_source/names_data_source.dart';
import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:flutter/services.dart';

class ColorNamesDataSource implements NamesDataSource {
  const ColorNamesDataSource();

  @override
  Future<Map<String, String>> loadNames() async {
    final colorNamesStr = await rootBundle.loadString(paths.colorNames);
    return Map<String, String>.from(jsonDecode(colorNamesStr));
  }
}