import 'package:colored/configuration/flavor.dart';
import 'package:colored/configuration/flavor_type.dart';
import 'package:colored/configuration/flavor_values/dev_values.dart';
import 'package:colored/configuration/flavor_values/flavor_values.dart';
import 'package:colored/configuration/flavor_values/local_data_values.dart';

class FlavorConfig implements Flavor {
  factory FlavorConfig({
    required FlavorType flavorType,
  }) =>
      _instance = FlavorConfig._internal(
        flavorType,
        _getFlavorValuesForFlavor(flavorType),
      );

  const FlavorConfig._internal(this.flavorType, this.values);

  static FlavorConfig get instance => _instance;

  static late final FlavorConfig _instance;

  final FlavorType flavorType;

  @override
  final FlavorValues values;

  static FlavorValues _getFlavorValuesForFlavor(FlavorType flavorType) =>
      flavorType == FlavorType.localData
          ? const LocalDataValues()
          : const DevValues();

  @override
  bool isProduction() => _instance.flavorType == FlavorType.localData;

  @override
  bool isDevelopment() => _instance.flavorType == FlavorType.dev;
}
