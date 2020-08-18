import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:flutter/foundation.dart';

class MainTabsState {
  const MainTabsState({@required this.currentSelection})
      : assert(currentSelection != null);

  final MainTabsSelection currentSelection;
}
