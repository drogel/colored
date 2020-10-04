import 'dart:async';

import 'package:colored/sources/presentation/widgets/navigation/indexed_navigation_controller.dart';
import 'package:colored/sources/presentation/widgets/navigation/indexed_navigation_state.dart';

class IndexedNavigationInjector {
  const IndexedNavigationInjector();

  IndexedNavigationController injectController(
          [StreamController<IndexedNavigationState> stateController]) =>
      IndexedNavigationController(
        stateController:
            stateController ?? StreamController<IndexedNavigationState>(),
      );
}
