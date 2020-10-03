import 'dart:async';

import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/connectivity/connectivity_service.dart';
import 'package:colored/sources/data/services/naming/naming_response.dart';
import 'package:colored/sources/data/services/naming/naming_service.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/data_models/naming_result.dart';
import 'package:colored/sources/domain/view_models/naming/naming_state.dart';
import 'package:colored/sources/domain/view_models/naming/naming_view_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:connectivity_platform_interface/src/enums.dart';
import 'package:flutter_test/flutter_test.dart';

class NamingServiceSuccessStub implements NamingService {
  static const String name = "testColor";

  @override
  Future<NamingResponse> getNaming({String hexColor}) async =>
      const NamingResponse(
        result: NamingResult(name: name, hex: "testHex"),
        response: ResponseStatus.ok,
      );
}

class NamingServiceFailureStub implements NamingService {
  @override
  Future<NamingResponse> getNaming({String hexColor}) async =>
      const NamingResponse(response: ResponseStatus.failed);
}

class ConverterStub implements Converter {
  @override
  Map<Format, String> convert(int r, int g, int b) =>
      {Format.hex: "mockedConversion"};
}

class ConnectivityServiceSuccessStub implements ConnectivityService {
  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      StreamController<ConnectivityResult>().stream;
}

void main() {
  NamingViewModel viewModel;
  StreamController<NamingState> stateController;
  NamingService namingService;
  Converter converter;

  group("Given a NamingViewModel with successful NamingService requests", () {
    setUp(() {
      stateController = StreamController<NamingState>();
      namingService = NamingServiceSuccessStub();
      converter = ConverterStub();
      viewModel = NamingViewModel(
        stateController: stateController,
        namingService: namingService,
        converter: converter,
      );
    });

    tearDown(() {
      stateController.close();
      stateController = null;
      namingService = null;
      converter = null;
      viewModel = null;
    });

    group("when constructed", () {
      test("then an assertion error is thrown if stateController is null", () {
        expect(
          () => NamingViewModel(
            stateController: null,
            namingService: namingService,
            converter: converter,
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then an assertion error is thrown if namingService is null", () {
        expect(
          () => NamingViewModel(
            stateController: stateController,
            namingService: null,
            converter: converter,
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then an assertion error is thrown if converter is null", () {
        expect(
          () => NamingViewModel(
            stateController: stateController,
            namingService: namingService,
            converter: null,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group("when stateStream is called", () {
      test("the stream of the provided state controller is retrieved", () {
        expect(viewModel.stateStream, stateController.stream);
      });
    });

    group("when initialState is called", () {
      test("then an Unknown state is retrieved", () async {
        final initialState = viewModel.initialState;
        expect(initialState.runtimeType, Unknown);
      });
    });

    group("when dispose is called", () {
      test("then stateController is closed", () {
        expect(stateController.isClosed, false);
        viewModel.dispose();
        expect(stateController.isClosed, true);
      });
    });

    group("when fetchNaming is called", () {
      test("then a Changing state is added to the stream first", () async {
        final selection = ColorSelection(r: 0, g: 0, b: 0);
        await viewModel.fetchNaming(selection);
        final state = await stateController.stream.first;
        expect(state.runtimeType, Changing);
      });

      test("then a Named state is added to stream after Changing", () async {
        stateController.stream.skip(1).listen((event) {
          expectLater(event.runtimeType, Named);
        });
        final selection = ColorSelection(r: 0, g: 0, b: 0);
        await viewModel.fetchNaming(selection);
      });

      test("then a Named state with expected name is retrieved", () async {
        stateController.stream.skip(1).listen((event) {
          final name = (event as Named).name;
          expectLater(name, NamingServiceSuccessStub.name);
        });
        final selection = ColorSelection(r: 0, g: 0, b: 0);
        await viewModel.fetchNaming(selection);
      });
    });
  });

  group("Given a NamingViewModel with failing NamingService requests", () {
    setUp(() {
      stateController = StreamController<NamingState>();
      namingService = NamingServiceFailureStub();
      converter = ConverterStub();
      viewModel = NamingViewModel(
        stateController: stateController,
        namingService: namingService,
        converter: converter,
      );
    });

    tearDown(() {
      stateController.close();
      stateController = null;
      namingService = null;
      converter = null;
      viewModel = null;
    });

    group("when initialState is called", () {
      test("then an Unknown state is retrieved", () async {
        final initialState = viewModel.initialState;
        expect(initialState.runtimeType, Unknown);
      });
    });

    group("when fetchNaming is called", () {
      test("then a Changing state is added to the stream first", () async {
        final selection = ColorSelection(r: 0, g: 0, b: 0);
        await viewModel.fetchNaming(selection);
        final state = await stateController.stream.first;
        expect(state.runtimeType, Changing);
      });

      test("then an Unknown state is added to stream after Changing", () async {
        stateController.stream.skip(1).listen((event) {
          expectLater(event.runtimeType, Unknown);
        });
        final selection = ColorSelection(r: 0, g: 0, b: 0);
        await viewModel.fetchNaming(selection);
      });
    });
  });
}
