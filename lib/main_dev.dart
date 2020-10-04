import 'package:colored/configuration/flavor.dart';
import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/configuration/flavor_values/dev_values.dart';
import 'package:colored/sources/app/colored.dart';
import 'package:colored/sources/app/navigation/routers/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(flavor: Flavor.dev, values: const DevValues());
  runApp(const Colored(router: MainFlowRouter()));
}
