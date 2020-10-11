import 'dart:async';

import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/data/services/data_loader/color_suggestions_loader.dart';
import 'package:colored/sources/data/services/int_generator/random_unique_int_generator.dart';
import 'package:colored/sources/data/services/list_picker/string_list_picker.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/data/services/suggestions/cherry_picked_suggestions_service.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/color_suggestions_state.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/color_suggestions_view_model.dart';

class ColorSuggestionsInjector {
  const ColorSuggestionsInjector();

  ColorSuggestionsViewModel injectViewModel([
    StreamController<ColorSuggestionsState> stateController,
  ]) {
    final dataPath = FlavorConfig.instance.values.colorSuggestionData;
    return ColorSuggestionsViewModel(
      stateController:
          stateController ?? StreamController<ColorSuggestionsState>(),
      suggestionsService: CherryPickedSuggestionsService<String>(
        dataLoader: ColorSuggestionsLoader(
          stringBundle: const RootStringBundle(),
          colorSuggestionsDataPath: dataPath,
        ),
        listPicker: const StringListPicker(
          intGenerator: RandomUniqueIntGenerator(),
        ),
      ),
    );
  }
}
