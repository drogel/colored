import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_data.dart';
import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';
import 'package:flutter/material.dart';

class PalettesNavigationData extends IndexedNavigationData {
  const PalettesNavigationData({
    required IndexedNavigationState? state,
    required void Function(int) onNavigation,
    required Widget child,
    Key? key,
  })  : assert(child != null),
        super(key: key, state: state, onNavigation: onNavigation, child: child);

  static PalettesNavigationData? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType(aspect: PalettesNavigationData);
}
