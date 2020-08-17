import 'dart:async';

import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_state.dart';
import 'package:flutter/foundation.dart';

class MainTabsViewModel {
  const MainTabsViewModel({
    @required StreamController<MainTabsState> stateController,
  })  : assert(stateController != null),
        _stateController = stateController;

  final StreamController<MainTabsState> _stateController;

  MainTabsState get initialState => const MainTabsState(currentIndex: 0);

  Stream<MainTabsState> get stateStream => _stateController.stream;

  void navigateToIndex(int tabIndex) =>
      _stateController.sink.add(MainTabsState(currentIndex: tabIndex));

  void dispose() {
    _stateController.close();
  }
}
