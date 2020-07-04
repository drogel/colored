import 'package:colored/configuration/flavor.dart';
import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/app/colored.dart';
import 'package:colored/sources/app/navigation/routers/converter_router.dart';
import 'file:///D:/Programas/Flutter/colored/colored/lib/sources/app/navigation/router.dart';
import 'package:colored/sources/app/navigation/routers/on_boarding_router.dart';
import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:colored/sources/data/services/local_storage/local_storage_keys.dart'
    as keys;
import 'package:colored/sources/data/services/local_storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(flavor: Flavor.production);

  final initialRouter = await _getInitialRoute(const SharedPreferences());

  runApp(Colored(router: initialRouter));
}

Future<Router> _getInitialRoute(LocalStorage localStorage) async {
  if (kIsWeb) {
    return const ConverterRouter();
  } else {
    return _getMobileInitialRoute(localStorage);
  }
}

Future<Router> _getMobileInitialRoute(LocalStorage localStorage) async {
  final didOnBoard = await localStorage.getBool(key: keys.didOnBoard);
  if (didOnBoard == null) {
    return const OnBoardingRouter();
  }
  return didOnBoard ? const ConverterRouter() : const OnBoardingRouter();
}
