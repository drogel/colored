import 'package:colored/sources/app/navigation/flow_router.dart';
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/naming/naming_injector.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_layout.dart';
import 'package:colored/sources/presentation/pages/converter_page.dart';
import 'package:colored/sources/presentation/pages/naming_page.dart';
import 'package:colored/sources/presentation/widgets/page_routes/fade_out_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConverterRouter implements FlowRouter {
  const ConverterRouter();

  static const name = "converterFlow/";

  @override
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return _buildConverter(settings);
    }
  }

  Route _buildConverter(RouteSettings settings) => FadeOutRoute(
        builder: (_) => const NamingPage(
          injector: NamingInjector(),
          child: ConverterPage(
            injector: ConverterInjector(),
            child: ConverterLayout(),
          ),
        ),
        settings: settings,
      );
}
