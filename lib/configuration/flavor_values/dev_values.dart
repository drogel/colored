import 'package:colored/configuration/flavor_values/flavor_values.dart';
import 'package:colored/resources/mock_data_paths.dart' as data_paths;

class DevValues implements FlavorValues {
  const DevValues();

  @override
  String get colorData => data_paths.sampleColors;

  @override
  String get colorSuggestionData => data_paths.sampleColorSuggestions;

  @override
  String get paletteData => data_paths.samplePalettes;

  @override
  String get paletteSuggestionData => data_paths.samplePaletteSuggestions;

  @override
  String get repositoryLink => data_paths.mockRepositoryLink;
}
