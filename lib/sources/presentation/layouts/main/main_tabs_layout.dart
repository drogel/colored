import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_data.dart';
import 'package:colored/sources/presentation/layouts/main/main_app_bar.dart';
import 'package:colored/sources/presentation/layouts/main/main_body_layout.dart';
import 'package:colored/sources/presentation/widgets/tabs/bottom_tab_bar.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
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
    final currentIndex = data.state.currentIndex;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBar(
        currentIndex: currentIndex,
        children: appBars,
      ),
      body: MainBodyLayout(
        currentIndex: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomTabBar(
        onTap: (newIndex) => _updateCurrentIndex(newIndex, data),
        currentIndex: currentIndex,
        tabs: pages,
      ),
    );
  }

  void _updateCurrentIndex(int newIndex, MainTabsData data) =>
      data.onNavigationToTabIndex(newIndex);
}
