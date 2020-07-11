import 'package:colored/sources/data/services/map_filter/map_filter.dart';

class ColorNamesFilter implements MapFilter<String> {
  const ColorNamesFilter();

  @override
  Map<String, String> filter(String search, Map<String, String> map) {
    final tmpCopy = Map<String, String>.from(map);
    tmpCopy.removeWhere((hex, name) => _noKeyOrValueFound(hex, name, search));
    return tmpCopy;
  }

  bool _containsSearch(String name, String searchString) =>
      name.toLowerCase().contains(searchString.toLowerCase());

  bool _noKeyOrValueFound(String key, String value, String search) =>
      !_containsSearch(key, search) && !_containsSearch(value, search);
}
