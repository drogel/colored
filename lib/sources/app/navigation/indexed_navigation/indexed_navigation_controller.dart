import 'dart:async';

import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';

class IndexedNavigationController {
  const IndexedNavigationController({
    required StreamController<IndexedNavigationState> stateController,
  }) : _stateController = stateController;

  final StreamController<IndexedNavigationState> _stateController;

  IndexedNavigationState get initialState => const IndexedNavigationState(0);

  Stream<IndexedNavigationState> get stateStream => _stateController.stream;

  void navigateToIndex(int selection) =>
      _stateController.sink.add(IndexedNavigationState(selection));

  void dispose() => _stateController.close();
}
