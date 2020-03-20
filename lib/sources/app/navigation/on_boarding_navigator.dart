import 'package:colored/sources/app/navigation/converter_navigator.dart';
import 'package:colored/sources/app/navigation/flow_navigator.dart';
import 'package:flutter/material.dart';

class OnBoardingNavigator extends StatelessWidget {
  const OnBoardingNavigator({Key key}) : super(key: key);

  static const onBoarding = "onBoarding/";
  static const converterFlow = "converterFlow/";

  @override
  Widget build(BuildContext context) => FlowNavigator(
        initialRoute: onBoarding,
        routes: {
          onBoarding: _buildOnBoarding,
          converterFlow: _buildConverterFlow,
        },
      );

  Route _buildOnBoarding(BuildContext context, RouteSettings settings) =>
      MaterialPageRoute(
        builder: (_) => Scaffold(body: Container()),
        settings: settings,
      );

  Route _buildConverterFlow(BuildContext context, RouteSettings settings) =>
      MaterialPageRoute(
        builder: (_) => const ConverterNavigator(),
        settings: settings,
      );
}
