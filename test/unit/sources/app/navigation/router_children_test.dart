import 'package:colored/sources/app/navigation/router.dart';
import 'package:flutter_test/flutter_test.dart';

import 'router_test_helpers.dart';

void main() {
  Router routerUnderTest;
  Router firstChild;
  Router secondChild;

  group("Given a Router with children", () {
    setUp(() {
      firstChild = FirstChildRouterStub();
      secondChild = SecondChildRouterStub();
      routerUnderTest = RouterUnderTest(children: [firstChild, secondChild]);
    });

    tearDown(() {
      routerUnderTest = null;
      firstChild = null;
      secondChild = null;
    });

    group("when onGenerateRoute is called", () {
      group("with a route name different from its children route names", () {
        test("then Route returned by its buildRoute method is obtained", () {
          runOnGenerateRouteTest(
            routerUnderTest,
            routeName: RouterUnderTest.routerName,
            expectedRouteType: MockRoute(),
          );

          runOnGenerateRouteTest(
            routerUnderTest,
            routeName: "someOtherName",
            expectedRouteType: MockRoute(),
          );
        });
      });

      group("with a route name that starts with a child router's name", () {
        test("then Route returned by the corresponding child is obtained", () {
          runOnGenerateRouteTest(
            routerUnderTest,
            routeName: FirstChildRouterStub.routerName,
            expectedRouteType: FirstChildRoute(),
          );

          const routeName = "${FirstChildRouterStub.routerName}someRouteName";
          runOnGenerateRouteTest(
            routerUnderTest,
            routeName: routeName,
            expectedRouteType: FirstChildRoute(),
          );
        });

        test("then Route returned by the corresponding child is obtained", () {
          runOnGenerateRouteTest(
            routerUnderTest,
            routeName: SecondChildRouterStub.routerName,
            expectedRouteType: SecondChildRoute(),
          );

          const routeName = "${SecondChildRouterStub.routerName}someRouteName";
          runOnGenerateRouteTest(
            routerUnderTest,
            routeName: routeName,
            expectedRouteType: SecondChildRoute(),
          );
        });
      });
    });
  });
}
