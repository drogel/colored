import 'package:colored/configuration/flavor_values/flavor_values.dart';

abstract class Flavor {
  FlavorValues get values;

  bool isProduction();

  bool isDevelopment();
}