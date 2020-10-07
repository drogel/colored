import 'dart:async';

import 'package:colored/sources/data/services/palette_naming/mock_palette_naming_service.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_view_model.dart';

class PaletteDetailInjector {
  const PaletteDetailInjector();

  PaletteDetailViewModel injectViewModel([
    StreamController<PaletteDetailState> stateController,
  ]) =>
      PaletteDetailViewModel(
        stateController:
            stateController ?? StreamController<PaletteDetailState>(),
        paletteNamingService: const MockPaletteNamingService(),
      );
}
