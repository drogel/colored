import 'dart:convert';

import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:flutter/services.dart';

class ColorNamesDataLoader implements DataLoader {
  const ColorNamesDataLoader();

  @override
  Future<Map<String, String>> load() async {
    final colorNamesStr = await rootBundle.loadString(paths.colorNames);
    return Map<String, String>.from(jsonDecode(colorNamesStr));
  }
}