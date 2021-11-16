@Timeout(Duration(milliseconds: 500))
import 'dart:async';

import 'package:colored/sources/data/api/services/base/request/api_request_builder.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPaletteNamingService extends Mock
    implements ApiRequestBuilder<NamedColor> {}

class PaletteNamingServiceSuccessStub implements ApiRequestBuilder<NamedColor> {
  static const black = NamedColor(name: "Black", hex: "#000000");

  static const white = NamedColor(name: "White", hex: "#FFFFFF");

  @override
  Future<ListPage<NamedColor>?> request(
    Iterable<String> queryParameters, {
    required PageInfo pageInfo,
  }) async {
    final namedColors = [black, white];
    return ListPage.singlePageFromItems(namedColors);
  }
}

class PaletteNamingServiceFailedStub implements ApiRequestBuilder<NamedColor> {
  @override
  Future<ListPage<NamedColor>?> request(
    Iterable<String> queryParameters, {
    required PageInfo pageInfo,
  }) async =>
      null;
}

void main() {
  late PaletteDetailViewModel viewModel;
  late ApiRequestBuilder<NamedColor> namingService;
  late StreamController<PaletteDetailState> stateController;

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

      test("then the Pending state is empty", () {
        final actual = viewModel.initialState;
        expect(actual.paletteName.isEmpty, isTrue);
      });
    });

    group("when fetchColorNames is called", () {
      test("then nothing is added to the stream if hexCodes is null", () async {
        await viewModel.fetchColorNames(null, "title");
        viewModel.stateStream.listen(neverCalled);
      });

      test("then nothing is added to stream if hexCodes is empty", () async {
        await viewModel.fetchColorNames([], "title");
        viewModel.stateStream.listen(neverCalled);
      });

      test("then nothing is added to the stream if name is null", () async {
        await viewModel.fetchColorNames(["test"], null);
        viewModel.stateStream.listen(neverCalled);
      });

      test("then nothing is added to stream if name is empty", () async {
        await viewModel.fetchColorNames(["test"], "");
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
    });

    group("when fetchColorNames is called", () {
      test("then an event is added to stream on hexCodes not empty", () async {
        await viewModel.fetchColorNames(["test"], "name");
        final isStreamEmpty = await viewModel.stateStream.isEmpty;
        expect(isStreamEmpty, isFalse);
      });

      test("then a Pending state is first added to the stream", () async {
        await viewModel.fetchColorNames(["test"], "name");
        final actual = await viewModel.stateStream.first;
        expect(actual, isA<Pending>());
      });

      test("then a Pending state with palette name is first added", () async {
        const testName = "name";
        await viewModel.fetchColorNames(["test"], testName);
        final actual = await viewModel.stateStream.first;
        expect(actual.paletteName, testName);
      });

      test("then a Pending state with hex colors is added", () async {
        const testName = "name";
        const requestedCodes = ["test1", "test2"];
        await viewModel.fetchColorNames(requestedCodes, testName);
        final actual = await viewModel.stateStream.first as Pending;
        expect(actual.requestedHexCodes, requestedCodes);
      });

      test("then PaletteFound is added to stream after Pending", () async {
        await viewModel.fetchColorNames(["test"], "name");
        final actual = await viewModel.stateStream.skip(1).first;
        expect(actual, isA<PaletteFound>());
      });

      test("then PaletteFound has NamedColors provided by service", () async {
        await viewModel.fetchColorNames(["test"], "name");
        final actual = await viewModel.stateStream.skip(1).first;
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
    });

    group("when fetchColorNames is called", () {
      test("then an event is added to stream on hexCodes not empty", () async {
        await viewModel.fetchColorNames(["test"], "name");
        final isStreamEmpty = await viewModel.stateStream.isEmpty;
        expect(isStreamEmpty, isFalse);
      });

      test("then a Pending state is first added to the stream", () async {
        await viewModel.fetchColorNames(["test"], "name");
        final actual = await viewModel.stateStream.first;
        expect(actual, isA<Pending>());
      });

      test("then a Pending state with hex colors is added", () async {
        const testName = "name";
        const requestedCodes = ["test1", "test2"];
        await viewModel.fetchColorNames(requestedCodes, testName);
        final actual = await viewModel.stateStream.first as Pending;
        expect(actual.requestedHexCodes, requestedCodes);
      });

      test("then a Failed state is added to stream after Pending", () async {
        await viewModel.fetchColorNames(["test"], "name");
        final actual = await viewModel.stateStream.skip(1).first;
        expect(actual, isA<Failed>());
      });
    });
  });
}
