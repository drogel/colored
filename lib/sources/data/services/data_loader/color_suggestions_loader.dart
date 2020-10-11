import 'dart:convert';

import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/string_bundle/string_bundle.dart';
import 'package:flutter/foundation.dart';

class ColorSuggestionsLoader implements DataLoader<String> {
  const ColorSuggestionsLoader({
    @required StringBundle stringBundle,
    @required String colorSuggestionsDataPath,
  })  : assert(stringBundle != null),
        assert(colorSuggestionsDataPath != null),
        _colorSuggestionsDataPath = colorSuggestionsDataPath,
        _stringBundle = stringBundle;

  final StringBundle _stringBundle;
  final String _colorSuggestionsDataPath;

  @override
  Future<Map<String, String>> load() async {
    final dataPath = _colorSuggestionsDataPath;
    final suggestionsStr = await _stringBundle.load(dataPath);
    return Map<String, String>.from(jsonDecode(suggestionsStr));
  }
}
