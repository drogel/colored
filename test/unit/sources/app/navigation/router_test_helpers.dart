import 'package:colored/sources/app/navigation/flow_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRoute extends Mock implements Route {}

class FirstChildRoute extends Mock implements Route {}

class SecondChildRoute extends Mock implements Route {}

class FirstChildFlowRouterStub extends FlowRouter {
  static const routerName = "firstChild";

  @override
  String get name => routerName;

  @override
  Route buildRoute(RouteSettings settings) => FirstChildRoute();
}

class SecondChildFlowRouterStub extends FlowRouter {
  static const routerName = "secondChild";

  @override
  String get name => routerName;

  @override
  Route buildRoute(RouteSettings settings) => SecondChildRoute();
}

class FlowRouterUnderTest extends FlowRouter {
  const FlowRouterUnderTest({List<FlowRouter>? children})
      : super(children: children);

  static const routerName = "routerUnderTest";

  @override
  String get name => routerName;

  @override
  Route buildRoute(RouteSettings settings) => MockRoute();
}

void runOnGenerateRouteTest(
  FlowRouter routerUnderTest, {
  required String routeName,
  required Route expectedRouteType,
}) {
  final settings = RouteSettings(name: routeName);
  final actual = routerUnderTest.onGenerateRoute(settings);
  expect(actual.runtimeType == expectedRouteType.runtimeType, true);
}
