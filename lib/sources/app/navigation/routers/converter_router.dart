import 'package:colored/sources/app/navigation/routers/flow_router.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_injector.dart';
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_injector.dart';
import 'package:colored/sources/domain/view_models/naming/naming_injector.dart';
import 'package:colored/sources/domain/view_models/picker/picker_injector.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_layout.dart';
import 'package:colored/sources/presentation/notifiers/connectivity_notifier.dart';
import 'package:colored/sources/presentation/notifiers/converter_notifier.dart';
import 'package:colored/sources/presentation/notifiers/names_list_notifier.dart';
import 'package:colored/sources/presentation/notifiers/naming_notifier.dart';
import 'package:colored/sources/presentation/notifiers/picker_notifier.dart';
import 'package:colored/sources/presentation/widgets/page_routes/fade_out_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConverterRouter implements FlowRouter {
  const ConverterRouter();

  static const name = "converter/";

  @override
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return _buildConverter(settings);
    }
  }

  Route _buildConverter(RouteSettings settings) => FadeOutRoute(
        builder: (_) => const NamesListNotifier(
          injector: NamesListInjector(),
          child: ConverterNotifier(
            injector: ConverterInjector(),
            child: PickerNotifier(
              injector: PickerInjector(),
              child: ConnectivityNotifier(
                injector: ConnectivityInjector(),
                child: NamingNotifier(
                  injector: NamingInjector(),
                  child: ConverterLayout(),
                ),
              ),
            ),
          ),
        ),
        settings: settings,
      );
}
