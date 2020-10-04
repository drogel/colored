import 'dart:async';

import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_state.dart';
import 'package:flutter/foundation.dart';

class MainTabsViewModel {
  const MainTabsViewModel({
    @required StreamController<MainTabsState> stateController,
  })  : assert(stateController != null),
        _stateController = stateController;

  final StreamController<MainTabsState> _stateController;

  MainTabsState get initialState => const MainTabsState(
        currentSelection: MainTabsSelection.converter,
      );

  Stream<MainTabsState> get stateStream => _stateController.stream;

  void navigateToIndex(MainTabsSelection selection) =>
      _stateController.sink.add(MainTabsState(currentSelection: selection));

  void dispose() => _stateController.close();
}
