import 'dart:async';

import 'package:colored/sources/data/services/map_filter/color_names_filter.dart';
import 'package:colored/sources/data/services/memoizer/default_memoizer.dart';
import 'package:colored/sources/data/services/names/color_names_service.dart';
import 'package:colored/sources/data/services/data_loader/color_names_data_loader.dart';
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
          dataLoader: ColorNamesDataLoader(
            memoizer: DefaultMemoizer<Map<String, String>>(),
          ),
          filter: const ColorNamesFilter(),
        ),
      );
}
