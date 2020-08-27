import 'dart:async';

import 'package:colored/sources/data/services/list_picker/string_list_picker.dart';
import 'package:colored/sources/data/services/data_loader/color_suggestions_loader.dart';
import 'package:colored/sources/data/services/int_generator/random_unique_int_generator.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/data/services/suggestions/color_suggestions_service.dart';
import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_state.dart';
import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_view_model.dart';
import 'package:flutter/services.dart';

class ColorSuggestionsInjector {
  const ColorSuggestionsInjector();

  ColorSuggestionsViewModel injectViewModel([
    StreamController<ColorSuggestionsState> stateController,
  ]) =>
      ColorSuggestionsViewModel(
        stateController: StreamController<ColorSuggestionsState>(),
        suggestionsService: ColorSuggestionsService(
          dataLoader: const ColorSuggestionsLoader(
            stringBundle: RootStringBundle(),
          ),
          listPicker: const StringListPicker(
            intGenerator: RandomUniqueIntGenerator(),
          ),
        ),
      );
}
