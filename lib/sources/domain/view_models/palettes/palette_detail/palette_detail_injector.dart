import 'dart:async';

import 'package:colored/configuration/flavor.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/services/palette_naming/meodai_palette_naming_service.dart';
import 'package:colored/sources/data/services/palette_naming/mock_palette_naming_service.dart';
import 'package:colored/sources/data/services/url_composer/meodai_url_composer.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_view_model.dart';
import 'package:flutter/foundation.dart';

class PaletteDetailInjector {
  const PaletteDetailInjector({required Flavor flavor})
      : assert(flavor != null),
        _flavor = flavor;

  final Flavor _flavor;

  PaletteDetailViewModel injectViewModel([
    StreamController<PaletteDetailState>? stateController,
  ]) =>
      _flavor.isProduction()
          ? _injectViewModel(stateController)
          : _injectMockViewModel(stateController);

  PaletteDetailViewModel _injectMockViewModel(
    StreamController<PaletteDetailState>? stateController,
  ) =>
      PaletteDetailViewModel(
        stateController:
            stateController ?? StreamController<PaletteDetailState>(),
        paletteNamingService: const MockPaletteNamingService(),
      );

  PaletteDetailViewModel _injectViewModel(
    StreamController<PaletteDetailState>? stateController,
  ) =>
      PaletteDetailViewModel(
        stateController:
            stateController ?? StreamController<PaletteDetailState>(),
        paletteNamingService: const MeodaiPaletteNamingService(
          urlComposer: MeodaiUrlComposer(),
          networkClient: SafeHttpClient(),
        ),
      );
}
