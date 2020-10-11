import 'package:colored/configuration/flavor.dart';
import 'package:colored/configuration/flavor_type.dart';
import 'package:colored/configuration/flavor_values/flavor_values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlavorConfig implements Flavor {
  factory FlavorConfig({
    @required FlavorType flavorType,
    @required FlavorValues values,
  }) =>
      _instance ??= FlavorConfig._internal(
        flavorType,
        values,
      );

  const FlavorConfig._internal(this.flavorType, this.values);

  static FlavorConfig get instance => _instance;

  static FlavorConfig _instance;

  final FlavorType flavorType;

  @override
  final FlavorValues values;

  @override
  bool isProduction() => _instance.flavorType == FlavorType.production;

  @override
  bool isDevelopment() => _instance.flavorType == FlavorType.dev;
}
