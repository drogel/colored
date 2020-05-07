import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'flavor.dart';

class FlavorConfig {
  factory FlavorConfig({
    @required Flavor flavor,
    Color color = Colors.blue,
  }) =>
      _instance ??=
      FlavorConfig._internal(
          flavor, flavor.toString().split('.').last, color);

  FlavorConfig._internal(this.flavor, this.name, this.color);

  final Flavor flavor;
  final String name;
  final Color color;
  static FlavorConfig _instance;

  static FlavorConfig get instance => _instance;

  static bool isProduction() => _instance.flavor == Flavor.production;

  static bool isDevelopment() => _instance.flavor == Flavor.dev;
}
