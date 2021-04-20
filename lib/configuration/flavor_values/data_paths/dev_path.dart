import 'package:colored/configuration/flavor_values/data_paths/data_path.dart';
import 'package:colored/resources/mock_data_paths.dart' as data_paths;

class DevPath implements DataPath {
  const DevPath();

  @override
  String get colorData => data_paths.sampleColors;

  @override
  String get colorSuggestionData => data_paths.sampleColorSuggestions;

  @override
  String get paletteData => data_paths.samplePalettes;

  @override
  String get paletteSuggestionData => data_paths.samplePaletteSuggestions;
}
