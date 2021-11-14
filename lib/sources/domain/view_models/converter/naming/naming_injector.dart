import 'dart:async';

import 'package:colored/configuration/flavor.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/naming/color_naming_api_service.dart';
import 'package:colored/sources/data/color_helpers/converter/hex_converter.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/services/naming/mock_naming_service.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_state.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_view_model.dart';

class NamingInjector {
  const NamingInjector({required Flavor flavor}) : _flavor = flavor;

  final Flavor _flavor;

  NamingViewModel injectViewModel([
    StreamController<NamingState>? stateController,
  ]) =>
      _flavor.isProduction()
          ? _injectViewModel(stateController)
          : _injectMockViewModel(stateController);

  NamingViewModel _injectMockViewModel([
    StreamController<NamingState>? stateController,
  ]) =>
      NamingViewModel(
        stateController: stateController ?? StreamController<NamingState>(),
        namingService: const MockNamingService(),
        converter: const HexConverter(),
      );

  NamingViewModel _injectViewModel([
    StreamController<NamingState>? stateController,
  ]) =>
      NamingViewModel(
        stateController: stateController ?? StreamController<NamingState>(),
        namingService: const ColorNamingApiService(
          client: SafeHttpClient(),
          // TODO: - Inject ApiIndex.
          apiIndex: null,
          pageRequestBuilder: UriPageRequestBuilder(),
          parser: ApiResponseParser(),
        ),
        converter: const HexConverter(),
      );
}
