import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:colored/configuration/flavor_values.dart';
import 'flavor.dart';

class FlavorConfig {
  factory FlavorConfig({
    @required Flavor flavor,
    @required FlavorValues values,
    Color color = Colors.blue,
  }) =>
      _instance ??=
      FlavorConfig._internal(
          flavor, flavor.toString().split('.').last, color, values);

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);

  static FlavorConfig get instance => _instance;

  static bool isProduction() => _instance.flavor == Flavor.production;

  static bool isDevelopment() => _instance.flavor == Flavor.dev;

  static bool isQA() => _instance.flavor == Flavor.qa;

  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static FlavorConfig _instance;
}