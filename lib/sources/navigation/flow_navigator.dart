import 'dart:io';

import 'package:flutter/widgets.dart';

class FlowNavigator extends StatefulWidget {
  const FlowNavigator({
    @required this.initialRoute,
    @required this.routes,
    Key key,
  })  : assert(initialRoute != null),
        assert(routes != null),
        super(key: key);

  final String initialRoute;
  final Map<String, Route Function(BuildContext, RouteSettings)> routes;

  static _FlowNavigatorState of(BuildContext context) =>
      context.findAncestorStateOfType<_FlowNavigatorState>();

  @override
  _FlowNavigatorState createState() => _FlowNavigatorState();
}

class _FlowNavigatorState extends State<FlowNavigator> {
  final _childNavigatorKey = GlobalKey<NavigatorState>();

  void popOut<T extends Object>([T result]) =>
      FlowNavigator.of(context).pop(result);

  Future<void> pop<T extends Object>([T result]) async {
    final shouldPopFromParent = await _shouldPopFromParent();
    if (shouldPopFromParent) {
      popOut(result);
    }
  }

  Future<T> pushNamed<T extends Object>(
      String routeName, {
        Object arguments,
      }) =>
      _canPush(routeName)
          ? _childNavigatorKey.currentState.pushNamed(
        routeName,
        arguments: arguments,
      )
          : FlowNavigator.of(context)
          .pushNamed(routeName, arguments: arguments);

  Future<T> pushReplacementNamed<T extends Object, TO extends Object>(
      String routeName, {
        TO result,
        Object arguments,
      }) =>
      _canPush(routeName)
          ? _childNavigatorKey.currentState.pushReplacementNamed(
        routeName,
        result: result,
        arguments: arguments,
      )
          : FlowNavigator.of(context).pushReplacementNamed(
        routeName,
        result: result,
        arguments: arguments,
      );

  Future<T> pushNamedAndRemoveUntil<T extends Object>(
      String newRouteName,
      RoutePredicate predicate, {
        Object arguments,
      }) =>
      _canPush(newRouteName)
          ? _childNavigatorKey.currentState.pushNamedAndRemoveUntil(
        newRouteName,
        predicate,
        arguments: arguments,
      )
          : FlowNavigator.of(context).pushNamedAndRemoveUntil(
        newRouteName,
        predicate,
        arguments: arguments,
      );

  @override
  Widget build(BuildContext context) => Platform.isIOS
      ? _buildNavigator(context)
      : _buildScopedNavigator(context);

  Route _generateRoute(BuildContext context, RouteSettings settings) =>
      widget.routes[settings.name](context, settings);

  Future<bool> _shouldPopFromParent() async {
    final childNavigator = _childNavigatorKey.currentState;

    if (!childNavigator.canPop()) {
      return true;
    } else {
      childNavigator.pop();
      return false;
    }
  }

  Widget _buildScopedNavigator(BuildContext context) => WillPopScope(
    onWillPop: _shouldPopFromParent,
    child: _buildNavigator(context),
  );

  Widget _buildNavigator(BuildContext context) => Navigator(
    key: _childNavigatorKey,
    initialRoute: widget.initialRoute,
    onGenerateRoute: (settings) => _generateRoute(context, settings),
  );

  bool _canPush(String routeName) => widget.routes.keys.contains(routeName);
}
