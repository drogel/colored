import 'dart:convert';

import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/memoizer/memoizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PalettesLoader implements DataLoader<List<String>> {
  const PalettesLoader({
    @required Memoizer<Map<String, List<String>>> memoizer,
  })  : assert(memoizer != null),
        _memoizer = memoizer;

  final Memoizer<Map<String, List<String>>> _memoizer;

  @override
  Future<Map<String, List<String>>> load() async => _memoizer.runOnce(_load);

  Future<Map<String, List<String>>> _load() async {
    final palettesStr = await rootBundle.loadString(paths.palettes);
    return Map<String, List<String>>.from(jsonDecode(palettesStr));
  }
}
