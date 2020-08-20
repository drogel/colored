import 'package:colored/sources/app/main_injector.dart';
import 'package:colored/sources/app/navigation/router.dart';
import 'package:colored/sources/presentation/layouts/color_search/color_search_layout.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_page.dart';
import 'package:colored/sources/presentation/layouts/main/main_tabs_layout.dart';
import 'package:colored/sources/presentation/layouts/names_list/names_list_page.dart';
import 'package:colored/sources/presentation/layouts/naming/naming_layout.dart';
import 'package:colored/sources/presentation/widgets/page_routes/fade_out_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainRouter extends Router {
  const MainRouter({List<Router> children}) : super(children: children);

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
            ],
            pages: const [
              ConverterPage(),
              NamesListPage(),
            ],
          ),
        ),
        settings: settings,
      );
}
