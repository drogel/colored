import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/map_filter/map_filter.dart';
import 'package:colored/sources/data/services/names/names_service.dart';

class ColorNamesService implements NamesService<String> {
  ColorNamesService({
    required DataLoader<String> dataLoader,
    required MapFilter<String> filter,
  })  : _dataLoader = dataLoader,
        _filter = filter;

  final DataLoader<String> _dataLoader;
  final MapFilter<String> _filter;

  @override
  Future<Map<String, String>> fetchContainingSearch(String searchString) async {
    final colorNames = await _dataLoader.load();
    final filteredColorNames = _filter.filter(searchString, colorNames);
    return filteredColorNames;
  }
}
