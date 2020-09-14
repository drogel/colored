import 'package:colored/sources/app/main_injector.dart';
import 'package:colored/sources/app/navigation/flow_router.dart';
import 'package:colored/sources/presentation/layouts/search/color_search/color_search_layout.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_page.dart';
import 'package:colored/sources/presentation/layouts/main/main_tabs_layout.dart';
import 'package:colored/sources/presentation/layouts/lists/names_list/names_list_page.dart';
import 'package:colored/sources/presentation/layouts/naming/naming_layout.dart';
import 'package:colored/sources/presentation/layouts/search/palette_search/palette_search_layout.dart';
import 'package:colored/sources/presentation/layouts/lists/palettes_list/palettes_list_page.dart';
import 'package:colored/sources/presentation/widgets/page_routes/fade_out_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainFlowRouter extends FlowRouter {
  const MainFlowRouter({List<FlowRouter> children}) : super(children: children);

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
        builder: (_) => MainInjector(
          child: MainTabsLayout(
            appBars: const [
              NamingLayout(),
              ColorSearchLayout(),
              PaletteSearchLayout(),
            ],
            pages: const [
              ConverterPage(),
              NamesListPage(),
              PalettesListPage(),
            ],
          ),
        ),
        settings: settings,
      );
}
