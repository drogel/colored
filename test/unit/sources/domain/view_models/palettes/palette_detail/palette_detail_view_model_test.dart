import 'dart:async';

import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_response.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_service.dart';
import 'package:colored/sources/domain/data_models/naming_result.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

class PaletteNamingServiceSuccessStub implements PaletteNamingService {
  static const black =
      NamingResult(name: "Black", hex: "#000000", r: 0, b: 0, g: 0);

  static const white =
      NamingResult(name: "White", hex: "#FFFFFF", r: 255, b: 255, g: 255);

  @override
  Future<PaletteNamingResponse> getNaming({List<String> hexColors}) async =>
      const PaletteNamingResponse(
        ResponseStatus.ok,
        results: [black, white],
      );
}

void main() {
  PaletteDetailViewModel viewModel;
  PaletteNamingService namingService;
  StreamController<PaletteDetailState> stateController;

  group("Given a PaletteDetailViewModel with a sucessful response stub", () {
    setUp(() {
      stateController = StreamController<PaletteDetailState>();
      namingService = PaletteNamingServiceSuccessStub();
      viewModel = PaletteDetailViewModel(
        stateController: stateController,
        paletteNamingService: namingService,
      );
    });

    tearDown(() {
      stateController.close();
      viewModel = null;
      stateController = null;
      namingService = null;
    });

    group("when constructed", () {
      test("then an assertion error is thrown if stateController is null", () {
        expect(
          () => PaletteDetailViewModel(
            stateController: null,
            paletteNamingService: namingService,
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then an assertion error is thrown if stateController is null", () {
        expect(
          () => PaletteDetailViewModel(
            stateController: stateController,
            paletteNamingService: null,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group("when dispose is called", () {
      test("then the stateController should be closed", () {
        expect(stateController.isClosed, false);
        viewModel.dispose();
        expect(stateController.isClosed, true);
      });
    });
  });
}
