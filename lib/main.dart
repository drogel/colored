import 'package:colored/configuration/flavor.dart';
import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/app/colored.dart';
import 'package:colored/sources/app/navigation/converter_router.dart';
import 'package:colored/sources/app/navigation/flow_router.dart';
import 'package:colored/sources/app/navigation/on_boarding_router.dart';
import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:colored/sources/data/services/local_storage/local_storage_keys.dart'
    as keys;
import 'package:colored/sources/data/services/local_storage/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(flavor: Flavor.production);

  final initialRouter = await _getInitialRoute(const SharedPreferences());

  runApp(Colored(router: initialRouter));
}

Future<FlowRouter> _getInitialRoute(LocalStorage localStorage) async {
  final didOnBoard = await localStorage.getBool(key: keys.didOnBoard);
  if (didOnBoard == null) {
    return const OnBoardingRouter();
  }
  return didOnBoard ? const ConverterRouter() : const OnBoardingRouter();
}
