import 'dart:async';

import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_state.dart';
import 'package:colored/sources/domain/view_models/naming/naming_state.dart';
import 'package:flutter/foundation.dart';

class NamesListViewModel {
  const NamesListViewModel({
    @required StreamController<NamesListState> stateController,
    @required NamesService namesService,
  })  : assert(stateController != null),
        assert(namesService != null),
        _stateController = stateController,
        _namesService = namesService;

  final StreamController<NamesListState> _stateController;
  final NamesService _namesService;

  Stream<NamesListState> get stateStream => _stateController.stream;

  NamesListState get initialData => const Busy();

  Future<void> init() async {
    await _namesService.loadNames();
  }

  void dispose() => _stateController.close();
}
