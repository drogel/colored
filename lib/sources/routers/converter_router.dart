import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/routers/router.dart';
import 'package:flutter/material.dart';

class ConverterRouter extends Router {
  @override
  Route buildInitialRoute(BuildContext context, {RouteSettings settings}) =>
      MaterialPageRoute(
        builder: (_) => ConverterInjector.injectConverter(),
        settings: const RouteSettings(isInitialRoute: true),
      );

  @override
  RouterState createState() => _ConverterRouterState();
}

class _ConverterRouterState extends RouterState {}
