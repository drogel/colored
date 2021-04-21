import 'package:flutter/material.dart';

abstract class FlowRouter {
  const FlowRouter({this.children});

  final List<FlowRouter>? children;

  String get name;

  Route buildRoute(RouteSettings settings);

  Route onGenerateRoute(RouteSettings settings) {
    final children = this.children ?? [];
    final newRouteName = settings.name ?? "";
    for (final child in children) {
      if (newRouteName.startsWith(child.name)) {
        return child.onGenerateRoute(settings);
      }
    }
    return buildRoute(settings);
  }
}
