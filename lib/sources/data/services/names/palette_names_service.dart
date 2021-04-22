import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/map_filter/map_filter.dart';
import 'package:colored/sources/data/services/names/names_service.dart';

class PaletteNamesService implements NamesService<List<String>> {
  const PaletteNamesService({
    required DataLoader<List<String>> dataLoader,
    required MapFilter<List<String>> filter,
  })   : _dataLoader = dataLoader,
        _filter = filter;

  final DataLoader<List<String>> _dataLoader;
  final MapFilter<List<String>> _filter;

  @override
  Future<Map<String, List<String>>> fetchContainingSearch(
    String searchString,
  ) async {
    final palettes = await _dataLoader.load();
    final filteredPalettes = _filter.filter(searchString, palettes);
    return filteredPalettes;
  }
}
