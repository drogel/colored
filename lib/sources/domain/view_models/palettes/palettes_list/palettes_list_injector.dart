import 'dart:async';

import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/common/search_configurator/list_search_configurator.dart';
import 'package:colored/sources/data/pagination/list_paginator.dart';
import 'package:colored/sources/data/services/data_loader/palettes_loader.dart';
import 'package:colored/sources/data/services/map_filter/palette_filter.dart';
import 'package:colored/sources/data/services/memoizer/default_memoizer.dart';
import 'package:colored/sources/data/services/names/paginated_palette_names_service.dart';
import 'package:colored/sources/data/services/names/palette_names_service.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_view_model.dart';

class PalettesListInjector {
  const PalettesListInjector();

  PalettesListViewModel injectViewModel([
    StreamController<NamesListState>? stateController,
  ]) =>
      PalettesListViewModel(
        stateController: stateController ?? StreamController<NamesListState>(),
        namesService: PaginatedPaletteNamesService(
          namesService: PaletteNamesService(
            dataLoader: PalettesLoader(
              memoizer: DefaultMemoizer(),
              stringBundle: const RootStringBundle(),
              palettesDataPath:
                  FlavorConfig.instance.values.dataPath.paletteData,
            ),
            filter: const PaletteFilter(),
          ),
          paginator: const ListPaginator(),
        ),
        searchConfigurator: const ListSearchConfigurator(),
      );
}
