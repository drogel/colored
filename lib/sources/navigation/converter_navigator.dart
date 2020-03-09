import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/navigation/flow_navigator.dart';
import 'package:colored/sources/presentation/layouts/converter_layout.dart';
import 'package:colored/sources/presentation/pages/converter_page.dart';
import 'package:flutter/material.dart';

class ConverterNavigator extends StatelessWidget {
  const ConverterNavigator({Key key}) : super(key: key);

  static const converter = "converter/";

  @override
  Widget build(BuildContext context) => FlowNavigator(
        initialRoute: converter,
        routes: {
          converter: _buildConverter,
        },
      );

  Route _buildConverter(
    BuildContext context,
    RouteSettings settings,
  ) =>
      MaterialPageRoute(
        builder: (_) => const ConverterPage(
          injector: ConverterInjector(),
          child: ConverterLayout(),
        ),
        settings: const RouteSettings(isInitialRoute: true),
      );
}
