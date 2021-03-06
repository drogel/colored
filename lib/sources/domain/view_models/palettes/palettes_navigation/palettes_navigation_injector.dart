import 'dart:async';

import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_navigation/palettes_navigation_view_model.dart';

class PalettesNavigationInjector {
  const PalettesNavigationInjector();

  PalettesNavigationViewModel injectViewModel([
    StreamController<IndexedNavigationState>? stateController,
  ]) =>
      PalettesNavigationViewModel(
        stateController:
            stateController ?? StreamController<IndexedNavigationState>(),
      );
}
