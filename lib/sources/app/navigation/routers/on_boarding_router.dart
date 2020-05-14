import 'file:///D:/Programas/Flutter/colored/colored/lib/sources/app/navigation/routers/converter_router.dart';
import 'package:colored/sources/app/navigation/routers/flow_router.dart';
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_injector.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_layout.dart';
import 'package:colored/sources/presentation/pages/converter_page.dart';
import 'package:colored/sources/presentation/pages/on_boarding_page.dart';
import 'package:flutter/material.dart';

class OnBoardingRouter implements FlowRouter {
  const OnBoardingRouter();

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
