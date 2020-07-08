import 'package:colored/sources/app/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRoute extends Mock implements Route {}

class FirstChildRoute extends Mock implements Route {}

class SecondChildRoute extends Mock implements Route {}

class FirstChildRouter extends Router {
  static const routerName = "firstChild";

  @override
  String get name => routerName;

  @override
  Route buildRoute(RouteSettings settings) => FirstChildRoute();
}

class SecondChildRouter extends Router {
  static const routerName = "secondChild";

  @override
  String get name => routerName;

  @override
  Route buildRoute(RouteSettings settings) => SecondChildRoute();
}

class RouterUnderTest extends Router {
  const RouterUnderTest({List<Router> children}) : super(children: children);

  static const routerName = "routerUnderTest";

  @override
  String get name => routerName;

  @override
  Route buildRoute(RouteSettings settings) => MockRoute();
}

void runOnGenerateRouteTest(
  Router routerUnderTest, {
  @required String routeName,
  @required Route expectedRouteType,
}) {
  final settings = RouteSettings(name: routeName);
  final actual = routerUnderTest.onGenerateRoute(settings);
  expect(actual.runtimeType == expectedRouteType.runtimeType, true);
}
