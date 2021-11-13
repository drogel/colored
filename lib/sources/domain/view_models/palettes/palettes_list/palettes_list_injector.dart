import 'dart:async';

import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/names/palette_names_api_service.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/pagination/list_paginator.dart';
import 'package:colored/sources/data/services/data_loader/palettes_loader.dart';
import 'package:colored/sources/data/services/map_filter/palette_filter.dart';
import 'package:colored/sources/data/services/memoizer/default_memoizer.dart';
import 'package:colored/sources/data/services/names/paginated_palette_names_service.dart';
import 'package:colored/sources/data/services/names/palette_names_service.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_injector.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_view_model.dart';

class PalettesListInjector extends BaseNamesInjector<Palette> {
  const PalettesListInjector({ApiIndex? apiIndex}) : super(apiIndex: apiIndex);

  @override
  BaseNamesListViewModel<Palette> injectApiViewModel(
    ApiIndex apiIndex, [
    StreamController<NamesListState>? stateController,
  ]) =>
      PalettesListViewModel(
        stateController: stateController ?? StreamController<NamesListState>(),
        namesService: PaletteNamesApiService(
          client: const SafeHttpClient(),
          apiIndex: apiIndex,
          pageRequestBuilder: const UriPageRequestBuilder(),
          parser: const ApiResponseParser(),
        ),
      );

  @override
  BaseNamesListViewModel<Palette> injectLocalViewModel([
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
      );
}
