import 'dart:async';

import 'package:colored/sources/domain/view_models/names_list/names_list_state.dart';
import 'package:flutter/foundation.dart';

class NamesListViewModel {
  const NamesListViewModel({
    @required StreamController<NamesListState> stateController,
  })  : assert(stateController != null),
        _stateController = stateController;

  final StreamController<NamesListState> _stateController;

  Stream<NamesListState> get stateStream => _stateController.stream;

  NamesListState get initialData => const NamesListState();

  void dispose() => _stateController.close();
}
