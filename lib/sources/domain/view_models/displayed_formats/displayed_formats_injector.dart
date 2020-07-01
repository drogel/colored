import 'dart:async';

import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_state.dart';
import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_view_model.dart';

class DisplayedFormatsInjector {
  const DisplayedFormatsInjector();

  DisplayedFormatsViewModel injectViewModel([
    StreamController<DisplayedFormatsState> stateController,
  ]) =>
      DisplayedFormatsViewModel(
        stateController:
            stateController ?? StreamController<DisplayedFormatsState>(),
        displayedFormats: List<Format>.from(Format.values),
      );
}
