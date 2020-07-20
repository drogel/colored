import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({
    @required this.tabs,
    this.onTap,
    this.currentIndex,
    Key key,
  })  : assert(tabs != null),
        super(key: key);

  final List<TabPage> tabs;
  final void Function(int) onTap;
  final int currentIndex;

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
