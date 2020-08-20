import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/presentation/widgets/logos/colored_header.dart';
import 'package:colored/sources/presentation/widgets/logos/colored_logo.dart';
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
    final padding = PaddingData.of(context).paddingScheme;
    return Container(
      color: theme.primaryColor,
      child: Padding(
        padding: PaddingData.of(context).paddingScheme.large,
        child: Theme(
          data: theme.copyWith(highlightColor: Colors.transparent),
          child: SafeArea(
            child: NavigationRail(
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
