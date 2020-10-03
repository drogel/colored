import 'dart:async';

import 'package:colored/sources/data/services/data_loader/palettes_loader.dart';
import 'package:colored/sources/data/services/map_filter/palette_filter.dart';
import 'package:colored/sources/data/services/memoizer/default_memoizer.dart';
import 'package:colored/sources/data/services/names/palette_names_service.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/domain/view_models/lists/base/list_search_configurator.dart';
import 'package:colored/sources/domain/view_models/lists/palettes_list/palettes_list_state.dart';
import 'package:colored/sources/domain/view_models/lists/palettes_list/palettes_list_view_model.dart';

class PalettesListInjector {
  const PalettesListInjector();

  PalettesListViewModel injectViewModel(
          [StreamController<PalettesListState> stateController]) =>
      PalettesListViewModel(
        stateController:
            stateController ?? StreamController<PalettesListState>(),
        namesService: PaletteNamesService(
          dataLoader: PalettesLoader(
            memoizer: DefaultMemoizer(),
            stringBundle: const RootStringBundle(),
          ),
          filter: const PaletteFilter(),
        ),
        searchConfigurator: const ListSearchConfigurator(),
      );
}
