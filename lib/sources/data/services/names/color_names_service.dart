import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/map_filter/map_filter.dart';
import 'package:colored/sources/data/services/names/base_names_service.dart';

class ColorNamesService extends BaseNamesService<String> {
  ColorNamesService({
    required DataLoader<String> dataLoader,
    required MapFilter<String> filter,
  }) : super(dataLoader: dataLoader, filter: filter);
}
