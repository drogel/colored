import 'package:colored/sources/presentation/widgets/tabs/base_tab_bar.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class BottomTabBar extends BaseTabBar {
  const BottomTabBar({
    @required List<TabPage> tabs,
    void Function(int) onTap,
    int currentIndex,
    Key key,
  }) : super(
          tabs: tabs,
          onTap: onTap,
          currentIndex: currentIndex,
          key: key,
        );

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        items: _buildTabItems(context),
      );

  List<BottomNavigationBarItem> _buildTabItems(BuildContext context) => tabs
      .map(
        (page) => BottomNavigationBarItem(
          icon: Icon(page.tabIcon),
          title: Text(page.getTabTitle(context)),
        ),
      )
      .toList();
}
