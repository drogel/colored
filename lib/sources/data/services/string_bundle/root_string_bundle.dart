import 'package:colored/sources/data/services/string_bundle/string_bundle.dart';
import 'package:flutter/services.dart';

class RootStringBundle implements StringBundle {
  const RootStringBundle();

  @override
  Future<String> load(String key) => rootBundle.loadString(key);
}
