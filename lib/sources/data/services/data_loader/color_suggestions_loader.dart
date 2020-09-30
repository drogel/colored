import 'dart:convert';

import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/string_bundle/string_bundle.dart';
import 'package:flutter/foundation.dart';

class ColorSuggestionsLoader implements DataLoader<String> {
  const ColorSuggestionsLoader({@required StringBundle stringBundle})
      : assert(stringBundle != null),
        _stringBundle = stringBundle;

  final StringBundle _stringBundle;

  @override
  Future<Map<String, String>> load() async {
    final dataPath = FlavorConfig.instance?.values?.colorSuggestionData;
    final suggestionsStr = await _stringBundle.load(dataPath);
    return Map<String, String>.from(jsonDecode(suggestionsStr));
  }
}
