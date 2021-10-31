import 'package:colored/configuration/flavor_values/data_paths/data_path.dart';
import 'package:colored/configuration/flavor_values/data_paths/dev_path.dart';
import 'package:colored/configuration/flavor_values/flavor_values.dart';
import 'package:colored/resources/mock_data_paths.dart' as data_paths;

class DevValues implements FlavorValues {
  const DevValues();

  @override
  String get repositoryLink => data_paths.mockRepositoryLink;

  @override
  DataPath get dataPath => const DevPath();

  @override
  String get apiIndexLink => data_paths.mockApiIndexLink;
}
