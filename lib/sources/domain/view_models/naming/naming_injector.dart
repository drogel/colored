import 'dart:async';

import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/sources/data/color_helpers/converter/hex_converter.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/services/naming/color_naming_service.dart';
import 'package:colored/sources/data/services/naming/mock_naming_service.dart';
import 'package:colored/sources/data/url_composer/color_names_composer.dart';
import 'package:colored/sources/domain/view_models/naming/naming_state.dart';
import 'package:colored/sources/domain/view_models/naming/naming_view_model.dart';

class NamingInjector {
  const NamingInjector();

  NamingViewModel injectViewModel([
    StreamController<NamingState> stateController,
  ]) =>
      FlavorConfig.isProduction()
          ? _injectViewModel(stateController)
          : _injectMockViewModel(stateController);

  NamingViewModel _injectMockViewModel(
          StreamController<NamingState> stateController) =>
      NamingViewModel(
        stateController: stateController ?? StreamController<NamingState>(),
        namingService: const MockNamingService(),
        converter: const HexConverter(),
      );

  NamingViewModel _injectViewModel(
          StreamController<NamingState> stateController) =>
      NamingViewModel(
        stateController: stateController ?? StreamController<NamingState>(),
        namingService: const ColorNamingService(
          urlComposer: ColorNamesComposer(),
          networkClient: SafeHttpClient(),
        ),
        converter: const HexConverter(),
      );
}
