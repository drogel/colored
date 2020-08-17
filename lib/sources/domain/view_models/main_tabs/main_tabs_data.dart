import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_state.dart';
import 'package:flutter/material.dart';

class MainTabsData extends InheritedWidget {
  const MainTabsData({
    @required this.state,
    @required this.onNavigationToTabIndex,
    @required Widget child,
    Key key,
  })  : assert(child != null),
        assert(state != null),
        super(key: key, child: child);

  static MainTabsData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: MainTabsData);

  final MainTabsState state;
  final void Function(int) onNavigationToTabIndex;

  @override
  bool updateShouldNotify(MainTabsData oldWidget) => state != oldWidget.state;
}
