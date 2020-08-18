import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_data.dart';
import 'package:colored/sources/presentation/layouts/main/main_app_bar.dart';
import 'package:colored/sources/presentation/layouts/main/main_body_layout.dart';
import 'package:colored/sources/presentation/widgets/tabs/bottom_tab_bar.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:flutter/material.dart';

class MainTabsLayout extends StatelessWidget {
  const MainTabsLayout({@required this.pages, @required this.appBars, Key key})
      : assert(pages != null),
        assert(appBars != null),
        assert(pages.length == appBars.length),
        super(key: key);

  final List<TabPage> pages;
  final List<PreferredSizeWidget> appBars;

  @override
  Widget build(BuildContext context) {
    final data = MainTabsData.of(context);
    final currentSelection = data.state.currentSelection;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBar(
        currentIndex: currentSelection.rawValue,
        children: appBars,
      ),
      body: MainBodyLayout(
        currentIndex: currentSelection.rawValue,
        children: pages,
      ),
      bottomNavigationBar: BottomTabBar(
        onTap: (newIndex) => _updateCurrentSelection(newIndex, data),
        currentIndex: currentSelection.rawValue,
        tabs: pages,
      ),
    );
  }

  void _updateCurrentSelection(int newIndex, MainTabsData data) {
    final newSelection = MainTabsSelectionBuilder.fromRawValue(newIndex);
    data.onNavigation(newSelection);
  }
}
