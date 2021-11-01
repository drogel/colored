import 'package:colored/configuration/flavor_values/data_paths/data_path.dart';

abstract class FlavorValues {
  DataPath get dataPath;

  String get repositoryLink;

  String get apiIndexLink;
}
