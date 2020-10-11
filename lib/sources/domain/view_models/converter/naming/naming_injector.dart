import 'dart:async';

import 'package:colored/configuration/flavor.dart';
import 'package:colored/sources/data/color_helpers/converter/hex_converter.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/services/naming/meodai_naming_service.dart';
import 'package:colored/sources/data/services/naming/mock_naming_service.dart';
import 'package:colored/sources/data/services/url_composer/meodai_url_composer.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_state.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_view_model.dart';
import 'package:flutter/foundation.dart';

class NamingInjector {
  const NamingInjector({@required Flavor flavor})
      : assert(flavor != null),
        _flavor = flavor;

  final Flavor _flavor;

  NamingViewModel injectViewModel([
    StreamController<NamingState> stateController,
  ]) =>
      _flavor.isProduction()
          ? _injectViewModel(stateController)
          : _injectMockViewModel(stateController);

  NamingViewModel _injectMockViewModel(
    StreamController<NamingState> stateController,
  ) =>
      NamingViewModel(
        stateController: stateController ?? StreamController<NamingState>(),
        namingService: const MockNamingService(),
        converter: const HexConverter(),
      );

  NamingViewModel _injectViewModel(
    StreamController<NamingState> stateController,
  ) =>
      NamingViewModel(
        stateController: stateController ?? StreamController<NamingState>(),
        namingService: const MeodaiNamingService(
          urlComposer: MeodaiUrlComposer(),
          networkClient: SafeHttpClient(),
        ),
        converter: const HexConverter(),
      );
}
