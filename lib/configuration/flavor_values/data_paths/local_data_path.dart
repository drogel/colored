import 'package:colored/configuration/flavor_values/data_paths/data_path.dart';
import 'package:colored/resources/data_paths.dart' as data_paths;

class LocalDataPath implements DataPath {
  const LocalDataPath();

  @override
  String get colorData => data_paths.colors;

  @override
  String get colorSuggestionData => data_paths.colorSuggestions;

  @override
  String get paletteData => data_paths.palettes;

  @override
  String get paletteSuggestionData => data_paths.paletteSuggestions;
}
