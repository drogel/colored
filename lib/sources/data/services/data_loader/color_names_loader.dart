import 'dart:convert';

import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:colored/sources/data/services/memoizer/memoizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ColorNamesLoader implements DataLoader<String> {
  ColorNamesLoader({@required Memoizer<Map<String, String>> memoizer})
      : assert(memoizer != null),
        _memoizer = memoizer;

  final Memoizer<Map<String, String>> _memoizer;

  @override
  Future<Map<String, String>> load() async => _memoizer.runOnce(_load);

  Future<Map<String, String>> _load() async {
    final colorNamesStr = await rootBundle.loadString(paths.colors);
    return Map<String, String>.from(jsonDecode(colorNamesStr));
  }
}
