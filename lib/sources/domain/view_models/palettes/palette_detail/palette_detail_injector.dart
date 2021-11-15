import 'dart:async';

import 'package:colored/configuration/flavor.dart';
import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/palette_naming/palette_api_naming_service.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/services/palette_naming/mock_palette_naming_service.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_view_model.dart';

class PaletteDetailInjector {
  const PaletteDetailInjector({
    required Flavor flavor,
    this.apiIndex,
  }) : _flavor = flavor;

  final Flavor _flavor;
  final ApiIndex? apiIndex;

  PaletteDetailViewModel injectViewModel([
    StreamController<PaletteDetailState>? stateController,
  ]) =>
      _flavor.isProduction()
          ? _injectViewModel(stateController)
          : _injectMockViewModel(stateController);

  PaletteDetailViewModel _injectMockViewModel([
    StreamController<PaletteDetailState>? stateController,
  ]) =>
      PaletteDetailViewModel(
        stateController:
            stateController ?? StreamController<PaletteDetailState>(),
        paletteNamingService: const MockPaletteNamingService(),
      );

  PaletteDetailViewModel _injectViewModel([
    StreamController<PaletteDetailState>? stateController,
  ]) =>
      PaletteDetailViewModel(
        stateController:
            stateController ?? StreamController<PaletteDetailState>(),
        paletteNamingService: PaletteNamingApiService(
          client: const SafeHttpClient(),
          apiIndex: apiIndex,
          pageRequestBuilder: const UriPageRequestBuilder(),
          parser: const ApiResponseParser(),
        ),
      );
}
