import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/map_filter/map_filter.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:flutter/foundation.dart';

class PaletteNamesService implements NamesService<List<String>> {
  const PaletteNamesService({
    required DataLoader dataLoader,
    required MapFilter filter,
  })  : assert(dataLoader != null),
        assert(filter != null),
        _dataLoader = dataLoader,
        _filter = filter;

  final DataLoader _dataLoader;
  final MapFilter _filter;

  @override
  Future<Map<String, List<String>>> fetchContainingSearch(
    String searchString,
  ) async {
    final palettes = await _dataLoader.load();
    final filteredPalettes = _filter.filter(searchString, palettes);
    return filteredPalettes as FutureOr<Map<String, List<String>>>;
  }
}
