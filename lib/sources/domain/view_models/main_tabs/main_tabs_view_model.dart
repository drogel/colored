import 'dart:async';

import 'package:colored/sources/presentation/widgets/navigation/indexed_navigation_controller.dart';
import 'package:colored/sources/presentation/widgets/navigation/indexed_navigation_state.dart';
import 'package:flutter/foundation.dart';

class MainTabsViewModel extends IndexedNavigationController {
  const MainTabsViewModel({
    @required StreamController<IndexedNavigationState> stateController,
  })  : assert(stateController != null),
        super(stateController: stateController);
}
