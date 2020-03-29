import 'package:colored/sources/app/navigation/converter_router.dart';
import 'package:colored/sources/app/navigation/flow_router.dart';
import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_injector.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_layout.dart';
import 'package:colored/sources/presentation/pages/converter_page.dart';
import 'package:colored/sources/presentation/pages/on_boarding_page.dart';
import 'package:flutter/material.dart';
import 'package:colored/sources/data/services/local_storage/local_storage_keys.dart'
    as keys;

class OnBoardingRouter implements FlowRouter {
  const OnBoardingRouter();

  static const name = Navigator.defaultRouteName;

  static Future<String> getInitialRoute(LocalStorage localStorage) async {
    final didOnBoard = await localStorage.getBool(key: keys.didOnBoard);
    if (didOnBoard == null) {
      return name;
    }
    return didOnBoard ? ConverterRouter.name : name;
  }

  @override
  Route generateRoute(RouteSettings settings) {
    if (settings.name.startsWith(ConverterRouter.name)) {
      return const ConverterRouter().generateRoute(settings);
    }

    switch (settings.name) {
      default:
        return _buildOnBoarding(settings);
    }
  }

  Route _buildOnBoarding(RouteSettings settings) => MaterialPageRoute(
        builder: (_) => const ConverterPage(
          injector: ConverterInjector(),
          child: OnBoardingPage(
            injector: OnBoardingInjector(),
            child: OnBoardingLayout(),
          ),
        ),
        settings: settings,
      );
}