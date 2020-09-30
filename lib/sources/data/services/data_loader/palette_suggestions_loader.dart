import 'dart:convert';

import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/string_bundle/string_bundle.dart';
import 'package:flutter/foundation.dart';

class PaletteSuggestionsLoader implements DataLoader<List<String>> {
  const PaletteSuggestionsLoader({@required StringBundle stringBundle})
      : assert(stringBundle != null),
        _stringBundle = stringBundle;

  final StringBundle _stringBundle;

  @override
  Future<Map<String, List<String>>> load() async {
    const path = paths.paletteSuggestions;
    final suggestionsStr = await _stringBundle.load(path);
    final jsonMap = Map<String, dynamic>.from(jsonDecode(suggestionsStr));

    return jsonMap.map((k, v) => MapEntry(k, List<String>.from(v)));
  }
}
