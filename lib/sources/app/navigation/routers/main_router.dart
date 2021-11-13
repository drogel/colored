import 'package:colored/sources/app/main_injector.dart';
import 'package:colored/sources/app/navigation/flow_router.dart';
import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/presentation/layouts/colors/color_search/color_search_layout.dart';
import 'package:colored/sources/presentation/layouts/colors/names_list/names_list_page.dart';
import 'package:colored/sources/presentation/layouts/converter/converter/converter_page.dart';
import 'package:colored/sources/presentation/layouts/converter/naming/naming_layout.dart';
import 'package:colored/sources/presentation/layouts/main_tabs/main_tabs_layout.dart';
import 'package:colored/sources/presentation/layouts/palettes/palettes_navigation/palettes_app_bar_layout.dart';
import 'package:colored/sources/presentation/layouts/palettes/palettes_navigation/palettes_page.dart';
import 'package:colored/sources/presentation/widgets/page_routes/fade_out_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainRouter extends FlowRouter {
  const MainRouter({this.apiIndex, List<FlowRouter>? children})
      : super(children: children);

  static const routerName = "/main";
  final ApiIndex? apiIndex;

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
          apiIndex: apiIndex,
          child: MainTabsLayout(
            appBars: const [
              NamingLayout(),
              ColorSearchLayout(),
              PalettesAppBarLayout(),
            ],
            pages: const [
              ConverterPage(),
              NamesListPage(),
              PalettesPage(),
            ],
          ),
        ),
        settings: RouteSettings(name: name, arguments: settings.arguments),
      );
}
