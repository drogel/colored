import 'dart:async';

import 'package:colored/sources/presentation/widgets/navigation/indexed_navigation_state.dart';
import 'package:flutter/foundation.dart';

class IndexedNavigationController {
  const IndexedNavigationController({
    @required StreamController<IndexedNavigationState> stateController,
  })  : assert(stateController != null),
        _stateController = stateController;

  final StreamController<IndexedNavigationState> _stateController;

  IndexedNavigationState get initialState => const IndexedNavigationState(0);

  Stream<IndexedNavigationState> get stateStream => _stateController.stream;

  void navigateToIndex(int selection) =>
      _stateController.sink.add(IndexedNavigationState(selection));

  void dispose() => _stateController.close();
}
