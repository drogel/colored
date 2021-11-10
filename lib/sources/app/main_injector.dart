import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/app/styling/colors/color_constants.dart'
    as colors;
import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/domain/view_models/converter/connectivity/connectivity_injector.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/converter/displayed_formats/displayed_formats_injector.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_injector.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_injector.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_injector.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_injector.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_injector.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_navigation/palettes_navigation_injector.dart';
import 'package:colored/sources/domain/view_models/converter/picker/picker_injector.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/color_suggestions_injector.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_injector.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_injector.dart';
import 'package:colored/sources/presentation/notifiers/colors/color_suggestions_notifier.dart';
import 'package:colored/sources/presentation/notifiers/converter/connectivity_notifier.dart';
import 'package:colored/sources/presentation/notifiers/converter/converter_notifier.dart';
import 'package:colored/sources/presentation/notifiers/converter/displayed_formats_notifier.dart';
import 'package:colored/sources/presentation/notifiers/main_tabs/main_tabs_notifier.dart';
import 'package:colored/sources/presentation/notifiers/colors/names_list_notifier.dart';
import 'package:colored/sources/presentation/notifiers/converter/naming_notifier.dart';
import 'package:colored/sources/presentation/notifiers/palettes/palette_detail_notifier.dart';
import 'package:colored/sources/presentation/notifiers/palettes/palette_suggestions_notifier.dart';
import 'package:colored/sources/presentation/notifiers/palettes/palettes_list_notifier.dart';
import 'package:colored/sources/presentation/notifiers/palettes/palettes_navigation_notifier.dart';
import 'package:colored/sources/presentation/notifiers/converter/picker_notifier.dart';
import 'package:colored/sources/presentation/notifiers/converter/transformer_notifier.dart';
import 'package:flutter/material.dart';

class MainInjector extends StatelessWidget {
  const MainInjector({
    required this.child,
    this.apiIndex,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final ApiIndex? apiIndex;

  @override
  Widget build(BuildContext context) => PaletteSuggestionsNotifier(
        injector: const PaletteSuggestionsInjector(),
        child: ColorSuggestionsNotifier(
          injector: const ColorSuggestionsInjector(),
          child: NamesListNotifier(
            injector: NamesListInjector(apiIndex: apiIndex),
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
                        injector: NamingInjector(
                          flavor: FlavorConfig.instance,
                        ),
                        child: PalettesListNotifier(
                          injector: const PalettesListInjector(),
                          child: PalettesNavigationNotifier(
                            injector: const PalettesNavigationInjector(),
                            child: PaletteDetailNotifier(
                              injector: PaletteDetailInjector(
                                flavor: FlavorConfig.instance,
                              ),
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
          ),
        ),
      );
}
