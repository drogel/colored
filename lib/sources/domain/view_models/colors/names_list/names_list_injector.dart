import 'dart:async';

import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/common/search_configurator/list_search_configurator.dart';
import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/names/color_names_api_service.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/pagination/list_paginator.dart';
import 'package:colored/sources/data/services/data_loader/color_names_loader.dart';
import 'package:colored/sources/data/services/map_filter/color_names_filter.dart';
import 'package:colored/sources/data/services/memoizer/default_memoizer.dart';
import 'package:colored/sources/data/services/names/color_names_service.dart';
import 'package:colored/sources/data/services/names/paginated_color_names_service.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_view_model.dart';

class NamesListInjector {
  const NamesListInjector({this.apiIndex});

  final ApiIndex? apiIndex;

  NamesListViewModel injectViewModel([
    StreamController<NamesListState>? stateController,
  ]) {
    final _apiIndex = apiIndex;
    if (_apiIndex == null) {
      return _injectLocalViewModel(stateController);
    } else {
      return _injectApiViewModel(_apiIndex, stateController);
    }
  }

  NamesListViewModel _injectLocalViewModel([
    StreamController<NamesListState>? stateController,
  ]) =>
      NamesListViewModel(
        stateController: stateController ?? StreamController<NamesListState>(),
        searchConfigurator: const ListSearchConfigurator(),
        namesService: PaginatedColorNamesService(
          namesService: ColorNamesService(
            dataLoader: ColorNamesLoader(
              memoizer: DefaultMemoizer<Map<String, String>>(),
              stringBundle: const RootStringBundle(),
              colorsDataPath: FlavorConfig.instance.values.dataPath.colorData,
            ),
            filter: const ColorNamesFilter(),
          ),
          paginator: const ListPaginator(),
        ),
      );

  NamesListViewModel _injectApiViewModel(
    ApiIndex apiIndex, [
    StreamController<NamesListState>? stateController,
  ]) =>
      NamesListViewModel(
        stateController: stateController ?? StreamController<NamesListState>(),
        searchConfigurator: const ListSearchConfigurator(),
        namesService: ColorNamesApiService(
          client: const SafeHttpClient(),
          apiIndex: apiIndex,
          parser: const ApiResponseParser(),
        ),
      );
}
