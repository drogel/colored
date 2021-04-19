import 'package:colored/configuration/flavor_values/dev_values.dart';
import 'package:colored/configuration/flavor_values/flavor_values.dart';
import 'package:colored/configuration/flavor_values/production_values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'flavor.dart';

class FlavorConfig {
  factory FlavorConfig({
    @required Flavor flavor,
    Color color = Colors.blue,
  n}) =>
      _instance ??= FlavorConfig._internal(
        flavor,
        flavor.toString().split('.').last,
        color,
        _getFlavorValuesForFlavor(flavor),
      );

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);

  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;

  static FlavorConfig _instance;

  static FlavorConfig get instance => _instance;

  static FlavorValues _getFlavorValuesForFlavor(Flavor flavor) =>
      flavor == Flavor.production
          ? const ProductionValues()
          : const DevValues();

  static bool isProduction() => _instance.flavor == Flavor.production;

  static bool isDevelopment() => _instance.flavor == Flavor.dev;
}
