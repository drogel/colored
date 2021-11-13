import 'dart:async';

import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';

abstract class NamesInjector<T> {
  BaseNamesListViewModel<T> injectViewModel([
    StreamController<NamesListState>? stateController,
  ]);
}

abstract class BaseNamesInjector<T> implements NamesInjector<T> {
  const BaseNamesInjector({this.apiIndex});

  final ApiIndex? apiIndex;

  @override
  BaseNamesListViewModel<T> injectViewModel([
    StreamController<NamesListState>? stateController,
  ]) {
    final _apiIndex = apiIndex;
    if (_apiIndex == null) {
      return injectLocalViewModel(stateController);
    } else {
      return injectApiViewModel(_apiIndex, stateController);
    }
  }

  BaseNamesListViewModel<T> injectLocalViewModel([
    StreamController<NamesListState>? stateController,
  ]);

  BaseNamesListViewModel<T> injectApiViewModel(
    ApiIndex apiIndex, [
    StreamController<NamesListState>? stateController,
  ]);
}
