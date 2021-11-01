import 'package:colored/configuration/flavor_values/data_paths/data_path.dart';
import 'package:colored/configuration/flavor_values/data_paths/local_data_path.dart';
import 'package:colored/configuration/flavor_values/flavor_values.dart';
import 'package:colored/resources/data_paths.dart' as data_paths;

class LocalDataValues implements FlavorValues {
  const LocalDataValues();

  @override
  String get repositoryLink => data_paths.githubRepositoryLink;

  @override
  DataPath get dataPath => const LocalDataPath();

  @override
  String get apiIndexLink => data_paths.apiIndexLink;
}
