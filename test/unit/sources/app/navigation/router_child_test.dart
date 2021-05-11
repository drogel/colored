import 'package:colored/sources/app/navigation/flow_router.dart';
import 'package:flutter_test/flutter_test.dart';

import 'router_test_helpers.dart';

void main() {
  late FlowRouter routerUnderTest;
  late FlowRouter childFlowRouter;

  group("Given a FlowRouter with a child", () {
    setUp(() {
      childFlowRouter = FirstChildFlowRouterStub();
      routerUnderTest = FlowRouterUnderTest(children: [childFlowRouter]);
    });

    group("when onGenerateRoute is called", () {
      group("with a route name different from its children route names", () {
        test("then Route returned by its buildRoute method is obtained", () {
          runOnGenerateRouteTest(
            routerUnderTest,
            routeName: FlowRouterUnderTest.routerName,
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
            routeName: FirstChildFlowRouterStub.routerName,
            expectedRouteType: FirstChildRoute(),
          );

          const routeName =
              "${FirstChildFlowRouterStub.routerName}someRouteName";
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
