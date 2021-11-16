import 'dart:async';

import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/suggestions/palette_suggestions_api_service.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/services/data_loader/palette_suggestions_loader.dart';
import 'package:colored/sources/data/services/int_generator/random_unique_int_generator.dart';
import 'package:colored/sources/data/services/list_picker/string_list_picker.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/data/services/suggestions/cherry_picked_suggestions_service.dart';
import 'package:colored/sources/data/services/suggestions/palettes_paginated_suggestions_service.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_view_model.dart';

class PaletteSuggestionsInjector {
  const PaletteSuggestionsInjector({this.apiIndex});

  final ApiIndex? apiIndex;

  PaletteSuggestionsViewModel injectViewModel([
    StreamController<PaletteSuggestionsState>? stateController,
  ]) {
    final _apiIndex = apiIndex;
    if (_apiIndex != null) {
      return _injectApiViewModel(_apiIndex, stateController);
    } else {
      return _injectLocalViewModel(stateController);
    }
  }

  PaletteSuggestionsViewModel _injectLocalViewModel([
    StreamController<PaletteSuggestionsState>? stateController,
  ]) {
    final path = FlavorConfig.instance.values.dataPath.paletteSuggestionData;
    return PaletteSuggestionsViewModel(
      stateController:
          stateController ?? StreamController<PaletteSuggestionsState>(),
      suggestionsService: PalettesPaginatedSuggestionsService(
        suggestionsService: CherryPickedSuggestionsService<List<String>>(
          dataLoader: PaletteSuggestionsLoader(
            stringBundle: const RootStringBundle(),
            paletteSuggestionsDataPath: path,
          ),
          listPicker: const StringListPicker(
            intGenerator: RandomUniqueIntGenerator(),
          ),
        ),
      ),
    );
  }

  PaletteSuggestionsViewModel _injectApiViewModel(
    ApiIndex apiIndex, [
    StreamController<PaletteSuggestionsState>? stateController,
  ]) =>
      PaletteSuggestionsViewModel(
        stateController:
            stateController ?? StreamController<PaletteSuggestionsState>(),
        suggestionsService: PaletteSuggestionsApiService(
          client: const SafeHttpClient(),
          apiIndex: apiIndex,
          pageRequestBuilder: const UriPageRequestBuilder(),
          parser: const ApiResponseParser(),
        ),
      );
}
