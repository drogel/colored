import 'package:colored/sources/app/navigation/routers/main_router.dart';
import 'package:colored/sources/app/navigation/flow_router.dart';
import 'package:colored/sources/app/styling/colors/color_constants.dart'
    as colors;
import 'package:colored/sources/domain/view_models/converter/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/converter/displayed_formats/displayed_formats_injector.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_injector.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_injector.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_layout.dart';
import 'package:colored/sources/presentation/notifiers/converter/converter_notifier.dart';
import 'package:colored/sources/presentation/notifiers/converter/displayed_formats_notifier.dart';
import 'package:colored/sources/presentation/notifiers/on_boarding/on_boarding_notifier.dart';
import 'package:colored/sources/presentation/notifiers/converter/transformer_notifier.dart';
import 'package:flutter/material.dart';

class OnBoardingFlowRouter extends FlowRouter {
  const OnBoardingFlowRouter() : super(children: const [MainFlowRouter()]);

  @override
  String get name => "/onboarding";

  @override
  Route buildRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return _buildOnBoarding(settings);
    }
  }

  Route _buildOnBoarding(RouteSettings settings) => MaterialPageRoute(
        builder: (_) => const TransformerNotifier(
          injector: TransformerInjector(initialColor: colors.primaryDark),
          child: ConverterNotifier(
            injector: ConverterInjector(),
            child: DisplayedFormatsNotifier(
              injector: DisplayedFormatsInjector(),
              child: OnBoardingNotifier(
                injector: OnBoardingInjector(),
                child: OnBoardingLayout(),
              ),
            ),
          ),
        ),
        settings: RouteSettings(name: name, arguments: settings.arguments),
      );
}
