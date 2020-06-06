import 'dart:async';

import 'package:colored/sources/data/services/names/color_names_service.dart';
import 'package:colored/sources/data/services/names/names_data_source/color_names_data_source.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_state.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_view_model.dart';

class NamesListInjector {
  const NamesListInjector();

  NamesListViewModel injectViewModel([
    StreamController<NamesListState> stateController,
  ]) =>
      NamesListViewModel(
        stateController: stateController ?? StreamController<NamesListState>(),
        namesService: ColorNamesService(
          dataSource: const ColorNamesDataSource(),
        ),
      );
}
