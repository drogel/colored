import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_data.dart';
import 'package:colored/sources/presentation/widgets/animations/app_bar_switcher.dart';
import 'package:colored/sources/presentation/widgets/animations/page_body_switcher.dart';
import 'package:colored/sources/presentation/widgets/tabs/bottom_tab_bar.dart';
import 'package:colored/sources/presentation/widgets/tabs/side_tab_bar.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

const _kSideBarWidth = 256.0;
const _kSideBarShownThreshold = 2 * _kSideBarWidth;
const _kSideBarExtendedThreshold = 4 * _kSideBarWidth;

class MainTabsLayout extends StatelessWidget {
  const MainTabsLayout({required this.pages, required this.appBars, Key? key})
      : assert(pages != null),
        assert(appBars != null),
        assert(pages.length == appBars.length),
        assert(pages.length == MainTabsSelection.values.length),
        super(key: key);

  final List<TabPage> pages;
  final List<PreferredSizeWidget> appBars;

  @override
  Widget build(BuildContext context) {
    final data = MainTabsData.of(context)!;
    final currentSelection = data.state!.currentIndex;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > _kSideBarShownThreshold;
        final isExtended = constraints.maxWidth > _kSideBarExtendedThreshold;
        return Row(
          children: [
            if (isWide)
              SideTabBar(
                onTap: data.onNavigation,
                currentIndex: currentSelection,
                tabs: pages,
                extended: isExtended,
                extendedWidth: _kSideBarWidth,
              ),
            if (isWide) const VerticalDivider(),
            Expanded(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBarSwitcher(
                  currentIndex: currentSelection,
                  children: appBars,
                ),
                body: PageBodySwitcher(
                  currentIndex: currentSelection,
                  children: pages,
                ),
                bottomNavigationBar: isWide
                    ? null
                    : BottomTabBar(
                        onTap: data.onNavigation,
                        currentIndex: currentSelection,
                        tabs: pages,
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
