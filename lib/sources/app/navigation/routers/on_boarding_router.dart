import 'package:colored/sources/app/navigation/routers/converter_router.dart';
import 'package:colored/sources/app/navigation/routers/flow_router.dart';
import 'package:colored/sources/app/styling/colors/color_constants.dart' as colors;
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_injector.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_injector.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_injector.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_layout.dart';
import 'package:colored/sources/presentation/notifiers/converter_notifier.dart';
import 'package:colored/sources/presentation/notifiers/displayed_formats_notifier.dart';
import 'package:colored/sources/presentation/notifiers/on_boarding_notifier.dart';
import 'package:colored/sources/presentation/notifiers/transformer_notifier.dart';
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
        settings: settings,
      );
}
