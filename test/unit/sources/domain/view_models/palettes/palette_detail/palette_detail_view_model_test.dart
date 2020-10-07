@Timeout(Duration(milliseconds: 500))
import 'dart:async';

import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_response.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_service.dart';
import 'package:colored/sources/domain/data_models/naming_result.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPaletteNamingService extends Mock implements PaletteNamingService {}

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

class PaletteNamingServiceFailedStub implements PaletteNamingService {
  @override
  Future<PaletteNamingResponse> getNaming({List<String> hexColors}) async =>
      const PaletteNamingResponse(ResponseStatus.failed);
}

void main() {
  PaletteDetailViewModel viewModel;
  PaletteNamingService namingService;
  StreamController<PaletteDetailState> stateController;

  group("Given a PaletteDetailViewModel", () {
    setUp(() {
      stateController = StreamController<PaletteDetailState>();
      namingService = MockPaletteNamingService();
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

    group("when stateStream is called", () {
      test("then the stream of the stateController is retrieved", () {
        final actual = viewModel.stateStream;
        expect(actual, stateController.stream);
      });
    });

    group("when initialState is called", () {
      test("then a Pending state is retrieved", () {
        final actual = viewModel.initialState;
        expect(actual, isA<Pending>());
      });
    });

    group("when fetchColorNames is called", () {
      test("then nothing is added to the stream if hexCodes is null", () async {
        await viewModel.fetchColorNames(null);
        viewModel.stateStream.listen(neverCalled);
      });

      test("then nothing is added to stream if hexCodes is empty", () async {
        await viewModel.fetchColorNames([]);
        viewModel.stateStream.listen(neverCalled);
      });
    });
  });

  group("Given a PaletteDetailViewModel with a successful service stub", () {
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

    group("when fetchColorNames is called", () {
      test("then an event is added to stream on hexCodes not empty", () async {
        await viewModel.fetchColorNames(["test"]);
        final isStreamEmpty = await viewModel.stateStream.isEmpty;
        expect(isStreamEmpty, isFalse);
      });

      test("then a PaletteFound state is added to the stream", () async {
        await viewModel.fetchColorNames(["test"]);
        final actual = await viewModel.stateStream.first;
        expect(actual, isA<PaletteFound>());
      });

      test("then PaletteFound has NamedColors provided by service", () async {
        await viewModel.fetchColorNames(["test"]);
        final actual = await viewModel.stateStream.first;
        final foundState = actual as PaletteFound;
        final firstFound = foundState.namedColors.first;
        final lastFound = foundState.namedColors.last;
        expect(foundState.namedColors.length, 2);
        expect(firstFound, PaletteNamingServiceSuccessStub.black);
        expect(lastFound, PaletteNamingServiceSuccessStub.white);
      });
    });
  });

  group("Given a PaletteDetailViewModel with a failing service stub", () {
    setUp(() {
      stateController = StreamController<PaletteDetailState>();
      namingService = PaletteNamingServiceFailedStub();
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

    group("when fetchColorNames is called", () {
      test("then an event is added to stream on hexCodes not empty", () async {
        await viewModel.fetchColorNames(["test"]);
        final isStreamEmpty = await viewModel.stateStream.isEmpty;
        expect(isStreamEmpty, isFalse);
      });

      test("then a Failed state is added to the stream", () async {
        await viewModel.fetchColorNames(["test"]);
        final actual = await viewModel.stateStream.first;
        expect(actual, isA<Failed>());
      });
    });
  });
}