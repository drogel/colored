import 'dart:async';

import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_controller.dart';
import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';

class IndexedNavigationInjector {
  const IndexedNavigationInjector();

  IndexedNavigationController injectController([
    StreamController<IndexedNavigationState>? stateController,
  ]) =>
      IndexedNavigationController(
        stateController:
            stateController ?? StreamController<IndexedNavigationState>(),
      );
}
