import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/presentation/widgets/tabs/side_tab_bar_background.dart';
import 'package:colored/sources/presentation/widgets/trademarks/about_mark.dart';
import 'package:colored/sources/presentation/widgets/trademarks/colored_header.dart';
import 'package:colored/sources/presentation/widgets/trademarks/colored_logo.dart';
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
    final padding = PaddingData.of(context).paddingScheme;
    return SideTabBarBackground(
      child: Stack(
        children: [
          NavigationRail(
            extended: extended,
            destinations: _buildTabItems(context),
            selectedIndex: currentIndex,
            onDestinationSelected: onTap,
            minExtendedWidth: extendedWidth,
            labelType: extended ? null : NavigationRailLabelType.all,
            leading: Padding(
              padding: EdgeInsets.only(bottom: padding.large.bottom),
              child: extended ? const ColoredHeader() : const ColoredLogo(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: padding.base),
              child: extended ? const AboutMark() : const AboutMark.compact(),
            ),
          )
        ],
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
