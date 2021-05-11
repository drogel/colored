import 'dart:async';

import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_controller.dart';
import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';

class MainTabsViewModel extends IndexedNavigationController {
  const MainTabsViewModel({
    required StreamController<IndexedNavigationState> stateController,
  }) : super(stateController: stateController);
}
