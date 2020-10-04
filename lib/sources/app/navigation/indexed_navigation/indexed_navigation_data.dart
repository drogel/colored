import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';
import 'package:flutter/material.dart';

class IndexedNavigationData extends InheritedWidget {
  const IndexedNavigationData({
    @required this.state,
    @required this.onNavigation,
    @required Widget child,
    Key key,
  })  : assert(child != null),
        assert(onNavigation != null),
        super(key: key, child: child);

  static IndexedNavigationData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: IndexedNavigationData);

  final IndexedNavigationState state;
  final void Function(int) onNavigation;

  @override
  bool updateShouldNotify(IndexedNavigationData oldWidget) =>
      state != oldWidget.state;
}
