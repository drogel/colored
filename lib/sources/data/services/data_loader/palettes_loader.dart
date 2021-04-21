import 'dart:convert';

import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/memoizer/memoizer.dart';
import 'package:colored/sources/data/services/string_bundle/string_bundle.dart';
import 'package:flutter/foundation.dart';

class PalettesLoader implements DataLoader<List<String>> {
  const PalettesLoader({
    required Memoizer<Map<String, List<String>>> memoizer,
    required StringBundle stringBundle,
    required String palettesDataPath,
  })  : assert(memoizer != null),
        assert(palettesDataPath != null),
        assert(stringBundle != null),
        _palettesDataPath = palettesDataPath,
        _stringBundle = stringBundle,
        _memoizer = memoizer;

  final Memoizer<Map<String, List<String>>> _memoizer;
  final StringBundle _stringBundle;
  final String _palettesDataPath;

  @override
  Future<Map<String, List<String>>> load() async => _memoizer.runOnce(_load);

  Future<Map<String, List<String>>> _load() async {
    final dataPath = _palettesDataPath;
    final palettesStr = await _stringBundle.load(dataPath);
    final jsonMap = Map<String, dynamic>.from(jsonDecode(palettesStr));
    return jsonMap.map((k, v) => MapEntry(k, List<String>.from(v)));
  }
}
