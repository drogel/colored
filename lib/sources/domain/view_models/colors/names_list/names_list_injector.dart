import 'dart:async';

import 'package:colored/sources/data/services/data_loader/color_names_loader.dart';
import 'package:colored/sources/data/services/map_filter/color_names_filter.dart';
import 'package:colored/sources/data/services/memoizer/default_memoizer.dart';
import 'package:colored/sources/data/services/names/color_names_service.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/common/search_configurator/list_search_configurator.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_view_model.dart';

import 'names_list_state.dart';

class NamesListInjector {
  const NamesListInjector();

  NamesListViewModel injectViewModel([
    StreamController<NamesListState> stateController,
  ]) =>
      NamesListViewModel(
        stateController: stateController ?? StreamController<NamesListState>(),
        searchConfigurator: const ListSearchConfigurator(),
        namesService: ColorNamesService(
          dataLoader: ColorNamesLoader(
            memoizer: DefaultMemoizer<Map<String, String>>(),
            stringBundle: const RootStringBundle(),
          ),
          filter: const ColorNamesFilter(),
        ),
      );
}
