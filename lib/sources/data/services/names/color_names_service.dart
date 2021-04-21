import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/map_filter/map_filter.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:flutter/foundation.dart';

class ColorNamesService implements NamesService<String> {
  ColorNamesService({
    required DataLoader dataLoader,
    required MapFilter filter,
  })  : assert(dataLoader != null),
        assert(filter != null),
        _dataLoader = dataLoader,
        _filter = filter;

  final DataLoader _dataLoader;
  final MapFilter _filter;

  @override
  Future<Map<String, String>> fetchContainingSearch(String searchString) async {
    final colorNames = await _dataLoader.load();
    final filteredColorNames = _filter.filter(searchString, colorNames);
    return filteredColorNames as FutureOr<Map<String, String>>;
  }
}
