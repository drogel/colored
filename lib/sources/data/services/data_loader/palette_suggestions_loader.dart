import 'dart:convert';

import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/string_bundle/string_bundle.dart';

class PaletteSuggestionsLoader implements DataLoader<List<String>> {
  const PaletteSuggestionsLoader({
    required StringBundle stringBundle,
    required String paletteSuggestionsDataPath,
  })  : _paletteSuggestionsDataPath = paletteSuggestionsDataPath,
        _stringBundle = stringBundle;

  final StringBundle _stringBundle;
  final String _paletteSuggestionsDataPath;

  @override
  Future<Map<String, List<String>>> load() async {
    final dataPath = _paletteSuggestionsDataPath;
    final suggestionsStr = await _stringBundle.load(dataPath);
    final jsonMap = Map<String, dynamic>.from(jsonDecode(suggestionsStr));
    return jsonMap.map((k, v) => MapEntry(k, List<String>.from(v)));
  }
}
