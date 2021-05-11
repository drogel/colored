import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_data.dart';
import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';
import 'package:flutter/material.dart';

class MainTabsData extends IndexedNavigationData {
  const MainTabsData({
    required IndexedNavigationState state,
    required void Function(int) onNavigation,
    required Widget child,
    Key? key,
  }) : super(state: state, onNavigation: onNavigation, child: child, key: key);

  static MainTabsData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: MainTabsData);
}
