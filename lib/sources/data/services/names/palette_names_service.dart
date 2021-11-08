import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/map_filter/map_filter.dart';
import 'package:colored/sources/data/services/names/base_names_service.dart';

class PaletteNamesService extends BaseNamesService<List<String>> {
  const PaletteNamesService({
    required DataLoader<List<String>> dataLoader,
    required MapFilter<List<String>> filter,
  }) : super(dataLoader: dataLoader, filter: filter);
}
