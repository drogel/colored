import 'dart:async';

import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/suggestions/palette_suggestions_search_api_service.dart';
import 'package:colored/sources/data/api/services/suggestions/suggestions_search_api_service.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/pagination/list_paginator.dart';
import 'package:colored/sources/data/services/data_loader/palette_suggestions_loader.dart';
import 'package:colored/sources/data/services/map_filter/palette_filter.dart';
import 'package:colored/sources/data/services/names/paginated_palette_names_service.dart';
import 'package:colored/sources/data/services/names/palette_names_service.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_injector.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/search/palette_suggestions_search_view_model.dart';

class PaletteSuggestionsSearchInjector extends BaseNamesInjector<Palette> {
  const PaletteSuggestionsSearchInjector({
    ApiIndex? apiIndex,
  }) : super(apiIndex: apiIndex);

  @override
  BaseNamesListViewModel<Palette> injectApiViewModel(
    ApiIndex apiIndex, [
    StreamController<NamesListState>? stateController,
  ]) =>
      PaletteSuggestionsSearchViewModel(
        stateController: stateController ?? StreamController<NamesListState>(),
        namesService: SuggestionsSearchApiService<Palette>(
          namesService: PaletteSuggestionsSearchApiService(
            client: const SafeHttpClient(),
            pageRequestBuilder: const UriPageRequestBuilder(),
            apiIndex: apiIndex,
            parser: const ApiResponseParser(),
          ),
        ),
      );

  @override
  BaseNamesListViewModel<Palette> injectLocalViewModel([
    StreamController<NamesListState>? stateController,
  ]) =>
      PaletteSuggestionsSearchViewModel(
        stateController: stateController ?? StreamController<NamesListState>(),
        namesService: PaginatedPaletteNamesService(
          namesService: PaletteNamesService(
            dataLoader: PaletteSuggestionsLoader(
              stringBundle: const RootStringBundle(),
              paletteSuggestionsDataPath:
                  FlavorConfig.instance.values.dataPath.paletteSuggestionData,
            ),
            filter: const PaletteFilter(),
          ),
          paginator: const ListPaginator(),
        ),
      );
}
