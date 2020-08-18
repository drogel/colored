import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/presentation/widgets/colored_header.dart';
import 'package:colored/sources/presentation/widgets/tabs/base_tab_bar.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class SideTabBar extends BaseTabBar {
  const SideTabBar({
    @required List<TabPage> tabs,
    this.extendedWidth = 256,
    this.extended = true,
    void Function(int) onTap,
    int currentIndex,
    Key key,
  }) : super(
          tabs: tabs,
          onTap: onTap,
          currentIndex: currentIndex,
          key: key,
        );

  final double extendedWidth;
  final bool extended;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.primaryColor,
      child: Padding(
        padding: PaddingData.of(context).paddingScheme.large,
        child: Theme(
          data: theme.copyWith(highlightColor: Colors.transparent),
          child: NavigationRail(
            leading: const ColoredHeader(),
            extended: true,
            destinations: _buildTabItems(context),
            selectedIndex: currentIndex,
            onDestinationSelected: onTap,
            minExtendedWidth: extendedWidth,
          ),
        ),
      ),
    );
  }

  List<NavigationRailDestination> _buildTabItems(BuildContext context) => tabs
      .map(
        (page) => NavigationRailDestination(
          icon: Icon(page.tabIcon),
          label: Text(page.getTabTitle(context)),
        ),
      )
      .toList();
}
