import 'package:colored/sources/app/navigation/router.dart';
import 'package:flutter_test/flutter_test.dart';

import 'router_test_helpers.dart';

void main() {
  Router routerUnderTest;
  Router childRouter;

  group("Given a Router with a child", () {
    setUp(() {
      childRouter = FirstChildRouterStub();
      routerUnderTest = RouterUnderTest(children: [childRouter]);
    });

    tearDown(() {
      routerUnderTest = null;
      childRouter = null;
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
      });
    });
  });
}
