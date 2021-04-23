import 'dart:async';

import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_view_model.dart';

class MainTabsInjector {
  const MainTabsInjector();

  MainTabsViewModel injectViewModel([
    StreamController<IndexedNavigationState>? stateController,
  ]) =>
      MainTabsViewModel(
        stateController:
            stateController ?? StreamController<IndexedNavigationState>(),
      );
}
