import 'package:colored/sources/app/navigation/converter_navigator.dart';
import 'package:colored/sources/app/navigation/flow_navigator.dart';
import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:colored/sources/data/services/local_storage/local_storage_keys.dart'
    as keys;
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/presentation/pages/converter_page.dart';
import 'package:colored/sources/presentation/pages/on_boarding_page.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_injector.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_layout.dart';
import 'package:colored/sources/presentation/widgets/page_routes/fade_out_route.dart';
import 'package:flutter/material.dart';

class OnBoardingNavigator extends StatelessWidget {
  const OnBoardingNavigator({
    @required this.initialRoute,
    Key key,
  }) : super(key: key);

  static const onBoarding = "onBoarding/";
  static const converterFlow = "converterFlow/";

  final String initialRoute;

  static Future<String> getInitialRoute(LocalStorage localStorage) async {
    final didOnBoard = await localStorage.getBool(key: keys.didOnBoard);
    if (didOnBoard == null) {
      return onBoarding;
    }
    return didOnBoard ? converterFlow : onBoarding;
  }

  @override
  Widget build(BuildContext context) => FlowNavigator(
        initialRoute: initialRoute,
        routes: {
          onBoarding: _buildOnBoarding,
          converterFlow: _buildConverterFlow,
        },
      );

  Route _buildOnBoarding(BuildContext context, RouteSettings settings) =>
      MaterialPageRoute(
        builder: (_) => const ConverterPage(
          injector: ConverterInjector(),
          child: OnBoardingPage(
            injector: OnBoardingInjector(),
            child: OnBoardingLayout(),
          ),
        ),
        settings: settings,
      );

  Route _buildConverterFlow(BuildContext context, RouteSettings settings) =>
      FadeOutRoute(enterWidget: const ConverterNavigator());
}
