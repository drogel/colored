import 'package:flutter/material.dart';

abstract class Router {
  const Router({this.children});

  final List<Router> children;

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
