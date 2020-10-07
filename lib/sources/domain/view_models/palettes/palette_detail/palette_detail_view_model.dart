import 'dart:async';

import 'package:colored/sources/data/services/palette_naming/palette_naming_service.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:flutter/foundation.dart';

class PaletteDetailViewModel {
  const PaletteDetailViewModel({
    @required StreamController<PaletteDetailState> stateController,
    @required PaletteNamingService paletteNamingService,
  })  : assert(stateController != null),
        assert(paletteNamingService != null),
        _stateController = stateController;

  final StreamController<PaletteDetailState> _stateController;

  Stream<PaletteDetailState> get stateStream => _stateController.stream;

  PaletteDetailState get initialState => const Pending();

  void dispose() => _stateController.close();
}
