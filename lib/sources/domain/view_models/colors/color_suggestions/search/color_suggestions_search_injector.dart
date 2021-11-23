import 'dart:async';

import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/suggestions/color_suggestions_search_api_service.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/pagination/list_paginator.dart';
import 'package:colored/sources/data/services/data_loader/color_suggestions_loader.dart';
import 'package:colored/sources/data/services/map_filter/color_names_filter.dart';
import 'package:colored/sources/data/services/names/color_names_service.dart';
import 'package:colored/sources/data/services/names/paginated_color_names_service.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_injector.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_view_model.dart';

class ColorSuggestionsSearchInjector extends BaseNamesInjector<NamedColor> {
  const ColorSuggestionsSearchInjector({
    ApiIndex? apiIndex,
  }) : super(apiIndex: apiIndex);

  @override
  BaseNamesListViewModel<NamedColor> injectApiViewModel(
    ApiIndex apiIndex, [
    StreamController<NamesListState>? stateController,
  ]) =>
      NamesListViewModel(
        stateController: stateController ?? StreamController<NamesListState>(),
        namesService: ColorSuggestionsSearchApiService(
          client: const SafeHttpClient(),
          pageRequestBuilder: const UriPageRequestBuilder(),
          apiIndex: apiIndex,
          parser: const ApiResponseParser(),
        ),
      );

  @override
  BaseNamesListViewModel<NamedColor> injectLocalViewModel([
    StreamController<NamesListState>? stateController,
  ]) =>
      NamesListViewModel(
        stateController: stateController ?? StreamController<NamesListState>(),
        namesService: PaginatedColorNamesService(
          namesService: ColorNamesService(
            dataLoader: ColorSuggestionsLoader(
              stringBundle: const RootStringBundle(),
              colorSuggestionsDataPath:
                  FlavorConfig.instance.values.dataPath.colorSuggestionData,
            ),
            filter: const ColorNamesFilter(),
          ),
          paginator: const ListPaginator(),
        ),
      );
}
