import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/map_filter/map_filter.dart';
import 'package:colored/sources/data/services/names/names_service.dart';

class BaseNamesService<T> implements NamesService<T> {
  const BaseNamesService({
    required DataLoader<T> dataLoader,
    required MapFilter<T> filter,
  })  : _dataLoader = dataLoader,
        _filter = filter;

  final DataLoader<T> _dataLoader;
  final MapFilter<T> _filter;

  @override
  Future<Map<String, T>> fetchContainingSearch(
    String searchString,
  ) async {
    final palettes = await _dataLoader.load();
    final filteredPalettes = _filter.filter(searchString, palettes);
    return filteredPalettes;
  }
}
