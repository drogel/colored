import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:flutter/foundation.dart';

class PaletteNamesService implements NamesService {
  const PaletteNamesService({@required DataLoader dataLoader})
      : assert(dataLoader != null),
        _dataLoader = dataLoader;

  final DataLoader _dataLoader;

  @override
  Future<Map<String, List<String>>> fetchNamesContaining(
    String searchString,
  ) async =>
      {};
}
