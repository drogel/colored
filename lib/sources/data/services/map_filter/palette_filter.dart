import 'package:colored/sources/data/services/map_filter/map_filter.dart';

class PaletteFilter implements MapFilter<List<String>> {
  const PaletteFilter();

  @override
  Map<String, List<String>> filter(
    String search,
    Map<String, List<String>> map,
  ) {
    final tmpCopy = Map<String, List<String>>.from(map);
    tmpCopy.removeWhere((key, value) => !_containsSearch(key, search));
    return tmpCopy;
  }

  bool _containsSearch(String name, String searchString) =>
      name.toLowerCase().contains(searchString.toLowerCase());
}
