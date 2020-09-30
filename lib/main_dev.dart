import 'package:colored/configuration/flavor.dart';
import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/configuration/flavor_values/production_values.dart';
import 'package:colored/sources/app/colored.dart';
import 'package:colored/sources/app/navigation/routers/on_boarding_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(flavor: Flavor.dev, values: const ProductionValues());
  runApp(const Colored(router: OnBoardingFlowRouter()));
}
