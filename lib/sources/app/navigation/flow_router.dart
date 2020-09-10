import 'package:flutter/material.dart';

abstract class FlowRouter {
  const FlowRouter({this.children});

  final List<FlowRouter> children;

  String get name;

  Route buildRoute(RouteSettings settings);

  Route onGenerateRoute(RouteSettings settings) {
    if (children != null) {
      for (final child in children) {
        if (settings.name.startsWith(child.name)) {
          return child.onGenerateRoute(settings);
        }
      }
    }

    return buildRoute(settings);
  }
}
