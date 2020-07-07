import 'package:colored/sources/app/navigation/router.dart';
import 'package:colored/sources/app/styling/colors/color_constants.dart'
    as colors;
import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_injector.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_injector.dart';
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_injector.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_injector.dart';
import 'package:colored/sources/domain/view_models/naming/naming_injector.dart';
import 'package:colored/sources/domain/view_models/picker/picker_injector.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_injector.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_layout.dart';
import 'package:colored/sources/presentation/notifiers/color_suggestions_notifier.dart';
import 'package:colored/sources/presentation/notifiers/connectivity_notifier.dart';
import 'package:colored/sources/presentation/notifiers/converter_notifier.dart';
import 'package:colored/sources/presentation/notifiers/displayed_formats_notifier.dart';
import 'package:colored/sources/presentation/notifiers/names_list_notifier.dart';
import 'package:colored/sources/presentation/notifiers/naming_notifier.dart';
import 'package:colored/sources/presentation/notifiers/picker_notifier.dart';
import 'package:colored/sources/presentation/notifiers/transformer_notifier.dart';
import 'package:colored/sources/presentation/widgets/page_routes/fade_out_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConverterRouter extends Router {
  const ConverterRouter({List<Router> children})
      : super(children: children);

  static const routerName = "converter/";

  @override
  String get name => routerName;

  @override
  Route buildRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return _buildConverter(settings);
    }
  }

  Route _buildConverter(RouteSettings settings) => FadeOutRoute(
        builder: (_) => const ColorSuggestionsNotifier(
          injector: ColorSuggestionsInjector(),
          child: NamesListNotifier(
            injector: NamesListInjector(),
            child: TransformerNotifier(
              injector: TransformerInjector(initialColor: colors.logoBlue),
              child: ConverterNotifier(
                injector: ConverterInjector(),
                child: DisplayedFormatsNotifier(
                  injector: DisplayedFormatsInjector(),
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
            ),
          ),
        ),
        settings: settings,
      );
}
