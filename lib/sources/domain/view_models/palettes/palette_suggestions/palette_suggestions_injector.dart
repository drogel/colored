import 'dart:async';

import 'package:colored/sources/data/services/data_loader/palette_suggestions_loader.dart';
import 'package:colored/sources/data/services/int_generator/random_unique_int_generator.dart';
import 'package:colored/sources/data/services/list_picker/string_list_picker.dart';
import 'package:colored/sources/data/services/string_bundle/root_string_bundle.dart';
import 'package:colored/sources/data/services/suggestions/cherry_picked_suggestions_service.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_view_model.dart';

class PaletteSuggestionsInjector {
  const PaletteSuggestionsInjector();

  PaletteSuggestionsViewModel injectViewModel([
    StreamController<PaletteSuggestionsState> stateController,
  ]) =>
      PaletteSuggestionsViewModel(
        stateController:
            stateController ?? StreamController<PaletteSuggestionsState>(),
        suggestionsService: CherryPickedSuggestionsService<List<String>>(
          dataLoader: const PaletteSuggestionsLoader(
            stringBundle: RootStringBundle(),
          ),
          listPicker: const StringListPicker(
            intGenerator: RandomUniqueIntGenerator(),
          ),
        ),
      );
}
