import 'package:colored/configuration/flavor_values/flavor_values.dart';
import 'package:colored/resources/data_paths.dart' as data_paths;

class ProductionValues implements FlavorValues {
  const ProductionValues();

  @override
  String get colorData => data_paths.colors;

  @override
  String get colorSuggestionData => data_paths.colorSuggestions;

  @override
  String get repositoryLink => data_paths.githubColoredLink;

  @override
  String get paletteData => data_paths.palettes;

  @override
  String get paletteSuggestionData => data_paths.paletteSuggestions;
}