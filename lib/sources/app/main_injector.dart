import 'package:colored/sources/app/styling/colors/color_constants.dart'
    as colors;
import 'package:colored/sources/domain/view_models/connectivity/connectivity_injector.dart';
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_injector.dart';
import 'package:colored/sources/domain/view_models/lists/names_list/names_list_injector.dart';
import 'package:colored/sources/domain/view_models/lists/palettes_list/palettes_list_injector.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_injector.dart';
import 'package:colored/sources/domain/view_models/naming/naming_injector.dart';
import 'package:colored/sources/domain/view_models/picker/picker_injector.dart';
import 'package:colored/sources/domain/view_models/suggestions/color_suggestions/color_suggestions_injector.dart';
import 'package:colored/sources/domain/view_models/suggestions/palette_suggestions/palette_suggestions_injector.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_injector.dart';
import 'package:colored/sources/presentation/notifiers/color_suggestions_notifier.dart';
import 'package:colored/sources/presentation/notifiers/connectivity_notifier.dart';
import 'package:colored/sources/presentation/notifiers/converter_notifier.dart';
import 'package:colored/sources/presentation/notifiers/displayed_formats_notifier.dart';
import 'package:colored/sources/presentation/notifiers/main_tabs_notifier.dart';
import 'package:colored/sources/presentation/notifiers/names_list_notifier.dart';
import 'package:colored/sources/presentation/notifiers/naming_notifier.dart';
import 'package:colored/sources/presentation/notifiers/palette_suggestions_notifier.dart';
import 'package:colored/sources/presentation/notifiers/palettes_list_notifier.dart';
import 'package:colored/sources/presentation/notifiers/picker_notifier.dart';
import 'package:colored/sources/presentation/notifiers/transformer_notifier.dart';
import 'package:flutter/material.dart';

class MainInjector extends StatelessWidget {
  const MainInjector({@required this.child, Key key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => PaletteSuggestionsNotifier(
        injector: const PaletteSuggestionsInjector(),
        child: ColorSuggestionsNotifier(
          injector: const ColorSuggestionsInjector(),
          child: NamesListNotifier(
            injector: const NamesListInjector(),
            child: TransformerNotifier(
              injector:
                  const TransformerInjector(initialColor: colors.logoBlue),
              child: ConverterNotifier(
                injector: const ConverterInjector(),
                child: DisplayedFormatsNotifier(
                  injector: const DisplayedFormatsInjector(),
                  child: PickerNotifier(
                    injector: const PickerInjector(),
                    child: ConnectivityNotifier(
                      injector: const ConnectivityInjector(),
                      child: NamingNotifier(
                        injector: const NamingInjector(),
                        child: PalettesListNotifier(
                          injector: const PalettesListInjector(),
                          child: MainTabsNotifier(
                            injector: const MainTabsInjector(),
                            child: child,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
