import 'package:colored/sources/presentation/layouts/main/main_app_bar.dart';
import 'package:colored/sources/presentation/layouts/main/main_body_layout.dart';
import 'package:colored/sources/presentation/widgets/tabs/bottom_tab_bar.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class MainTabsLayout extends StatefulWidget {
  const MainTabsLayout({@required this.pages, @required this.appBars, Key key})
      : assert(pages != null),
        assert(appBars != null),
        super(key: key);

  final List<TabPage> pages;
  final List<PreferredSizeWidget> appBars;

  @override
  _MainTabsLayoutState createState() => _MainTabsLayoutState();
}

class _MainTabsLayoutState extends State<MainTabsLayout> {
  int _currentIndex;

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MainAppBar(
          currentIndex: _currentIndex,
          children: widget.appBars,
        ),
        body: MainBodyLayout(
          currentIndex: _currentIndex,
          children: widget.pages,
        ),
        bottomNavigationBar: BottomTabBar(
          onTap: _updateCurrentIndex,
          currentIndex: _currentIndex,
          tabs: widget.pages,
        ),
      );

  void _updateCurrentIndex(int newIndex) =>
      setState(() => _currentIndex = newIndex);
}
