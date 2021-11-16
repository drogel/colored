import 'dart:async';

import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/suggestions/color_suggestions_api_service.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/services/data_loader/color_suggestions_loader.dart';
import 'package:colored/sources/data/services/int_generator/random_unique_int_generator.dart';
import 'package:colored/sources/data/services/list_picker/string_list_picker.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/data/services/suggestions/cherry_picked_suggestions_service.dart';
import 'package:colored/sources/data/services/suggestions/named_colors_paginated_suggestions_service.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/color_suggestions_state.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/color_suggestions_view_model.dart';

class ColorSuggestionsInjector {
  const ColorSuggestionsInjector({this.apiIndex});

  final ApiIndex? apiIndex;

  ColorSuggestionsViewModel injectViewModel([
    StreamController<ColorSuggestionsState>? stateController,
  ]) {
    final _apiIndex = apiIndex;
    if (_apiIndex != null) {
      return _injectApiViewModel(_apiIndex, stateController);
    } else {
      return _injectLocalViewModel(stateController);
    }
  }

  ColorSuggestionsViewModel _injectLocalViewModel([
    StreamController<ColorSuggestionsState>? stateController,
  ]) {
    final dataPath = FlavorConfig.instance.values.dataPath.colorSuggestionData;
    return ColorSuggestionsViewModel(
      stateController:
          stateController ?? StreamController<ColorSuggestionsState>(),
      suggestionsService: NamedColorsPaginatedSuggestionsService(
        suggestionsService: CherryPickedSuggestionsService<String>(
          dataLoader: ColorSuggestionsLoader(
            stringBundle: const RootStringBundle(),
            colorSuggestionsDataPath: dataPath,
          ),
          listPicker: const StringListPicker(
            intGenerator: RandomUniqueIntGenerator(),
          ),
        ),
      ),
    );
  }

  ColorSuggestionsViewModel _injectApiViewModel(
    ApiIndex apiIndex, [
    StreamController<ColorSuggestionsState>? stateController,
  ]) =>
      ColorSuggestionsViewModel(
        stateController:
            stateController ?? StreamController<ColorSuggestionsState>(),
        suggestionsService: ColorSuggestionsApiService(
          client: const SafeHttpClient(),
          apiIndex: apiIndex,
          pageRequestBuilder: const UriPageRequestBuilder(),
          parser: const ApiResponseParser(),
        ),
      );
}
