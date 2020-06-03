import 'dart:async';

import 'package:colored/sources/data/color_helpers/format_converter/format_converter.dart';
import 'package:colored/sources/data/services/api_response.dart';
import 'package:colored/sources/data/services/connectivity/connectivity_service.dart';
import 'package:colored/sources/data/services/naming/naming_response.dart';
import 'package:colored/sources/data/services/naming/naming_service.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
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
        response: ApiResponse.ok,
      );
}

class NamingServiceFailureStub implements NamingService {
  @override
  Future<NamingResponse> getNaming({String hexColor}) async =>
      const NamingResponse(response: ApiResponse.failed);
}

class FormatConverterStub implements FormatConverter {
  @override
  String convert(int r, int g, int b) => "mockedConversion";
}

class ConnectivityServiceSuccessStub implements ConnectivityService {
  @override
  Future<ConnectivityResult> checkConnectivity() async =>
      ConnectivityResult.mobile;
}

class ConnectivityServiceFailureStub implements ConnectivityService {
  @override
  Future<ConnectivityResult> checkConnectivity() async =>
      ConnectivityResult.none;
}

void main() {
  NamingViewModel viewModel;
  StreamController<NamingState> stateController;
  NamingService namingService;
  ConnectivityService connectivityService;
  FormatConverter formatConverter;

  group("Given a NamingViewModel with successful NamingService requests", () {
    setUp(() {
      stateController = StreamController<NamingState>();
      namingService = NamingServiceSuccessStub();
      connectivityService = ConnectivityServiceSuccessStub();
      formatConverter = FormatConverterStub();
      viewModel = NamingViewModel(
        stateController: stateController,
        namingService: namingService,
        connectivityService: connectivityService,
        converter: formatConverter,
      );
    });

    tearDown(() {
      stateController.close();
      stateController = null;
      namingService = null;
      formatConverter = null;
      connectivityService = null;
      viewModel = null;
    });

    group("when initialData is called", () {
      test("then an Unknown state is retrieved", () async {
        final initialState = viewModel.initialData;
        expect(initialState.runtimeType, Unknown);
      });
    });

    group("when fetchNaming is called", () {
      test("then a Changing state is added to the stream first", () async {
        final selection = ColorSelection(first: 0, second: 0, third: 0);
        await viewModel.fetchNaming(selection);
        final state = await stateController.stream.first;
        expect(state.runtimeType, Changing);
      });

      test("then a Named state is added to stream after Changing", () async {
        stateController.stream.skip(1).listen((event) {
          expectLater(event.runtimeType, Named);
        });
        final selection = ColorSelection(first: 0, second: 0, third: 0);
        await viewModel.fetchNaming(selection);
      });

      test("then a Named state with expected name is retrieved", () async {
        stateController.stream.skip(1).listen((event) {
          final name = (event as Named).name;
          expectLater(name, NamingServiceSuccessStub.name);
        });
        final selection = ColorSelection(first: 0, second: 0, third: 0);
        await viewModel.fetchNaming(selection);
      });
    });
  });

  group("Given a NamingViewModel with failing NamingService requests", () {
    setUp(() {
      stateController = StreamController<NamingState>();
      namingService = NamingServiceFailureStub();
      formatConverter = FormatConverterStub();
      connectivityService = ConnectivityServiceSuccessStub();
      viewModel = NamingViewModel(
        stateController: stateController,
        namingService: namingService,
        connectivityService: connectivityService,
        converter: formatConverter,
      );
    });

    tearDown(() {
      stateController.close();
      stateController = null;
      namingService = null;
      formatConverter = null;
      connectivityService = null;
      viewModel = null;
    });

    group("when initialData is called", () {
      test("then an Unknown state is retrieved", () async {
        final initialState = viewModel.initialData;
        expect(initialState.runtimeType, Unknown);
      });
    });

    group("when fetchNaming is called", () {
      test("then a Changing state is added to the stream first", () async {
        final selection = ColorSelection(first: 0, second: 0, third: 0);
        await viewModel.fetchNaming(selection);
        final state = await stateController.stream.first;
        expect(state.runtimeType, Changing);
      });

      test("then an Unknown state is added to stream after Changing", () async {
        stateController.stream.skip(1).listen((event) {
          expectLater(event.runtimeType, Unknown);
        });
        final selection = ColorSelection(first: 0, second: 0, third: 0);
        await viewModel.fetchNaming(selection);
      });
    });
  });

  group("Given a NamingViewModel with no network connectivity", () {
    setUp(() {
      stateController = StreamController<NamingState>();
      namingService = NamingServiceFailureStub();
      formatConverter = FormatConverterStub();
      connectivityService = ConnectivityServiceFailureStub();
      viewModel = NamingViewModel(
        stateController: stateController,
        namingService: namingService,
        connectivityService: connectivityService,
        converter: formatConverter,
      );
    });

    tearDown(() {
      stateController.close();
      stateController = null;
      namingService = null;
      formatConverter = null;
      connectivityService = null;
      viewModel = null;
    });

    group("when fetchNaming is called", () {
      test("then a Changing state is added to the stream first", () async {
        final selection = ColorSelection(first: 0, second: 0, third: 0);
        await viewModel.fetchNaming(selection);
        final state = await stateController.stream.first;
        expect(state.runtimeType, Changing);
      });

      test("then an Unknown state is added to stream after Changing", () async {
        stateController.stream.skip(1).listen((event) {
          expectLater(event.runtimeType, Unknown);
        });
        final selection = ColorSelection(first: 0, second: 0, third: 0);
        await viewModel.fetchNaming(selection);
      });
    });
  });
}
