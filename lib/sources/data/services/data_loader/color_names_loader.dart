import 'dart:convert';

import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/memoizer/memoizer.dart';
import 'package:colored/sources/data/services/string_bundle/string_bundle.dart';
import 'package:flutter/foundation.dart';

class ColorNamesLoader implements DataLoader<String> {
  ColorNamesLoader({
    @required Memoizer<Map<String, String>> memoizer,
    @required StringBundle stringBundle,
  })  : assert(memoizer != null),
        assert(stringBundle != null),
        _stringBundle = stringBundle,
        _memoizer = memoizer;

  final Memoizer<Map<String, String>> _memoizer;
  final StringBundle _stringBundle;

  @override
  Future<Map<String, String>> load() async => _memoizer.runOnce(_load);

  Future<Map<String, String>> _load() async {
    final colorNamesStr = await _stringBundle.load(paths.colors);
    return Map<String, String>.from(jsonDecode(colorNamesStr));
  }
}
