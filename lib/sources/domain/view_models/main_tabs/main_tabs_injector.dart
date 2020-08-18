import 'dart:async';

import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_state.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_view_model.dart';

class MainTabsInjector {
  const MainTabsInjector();

  MainTabsViewModel injectViewModel([
    StreamController<MainTabsState> stateController,
  ]) =>
      MainTabsViewModel(
        stateController: stateController ?? StreamController<MainTabsState>(),
      );
}
