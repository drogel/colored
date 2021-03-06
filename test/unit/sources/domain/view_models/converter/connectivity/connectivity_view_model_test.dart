import 'dart:async';

import 'package:colored/sources/data/services/connectivity/connectivity_service.dart';
import 'package:colored/sources/domain/view_models/converter/connectivity/connectivity_state.dart';
import 'package:colored/sources/domain/view_models/converter/connectivity/connectivity_view_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';

class ConnectivityServiceStub implements ConnectivityService {
  const ConnectivityServiceStub(this.connectivityController);

  final StreamController<ConnectivityResult>? connectivityController;

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      connectivityController!.stream;
}

void main() {
  late ConnectivityViewModel viewModel;
  late StreamController<ConnectivityState> stateController;
  late StreamController<ConnectivityResult> connectivityController;
  late ConnectivityService connectivityService;

  setUp(() {
    stateController = StreamController<ConnectivityState>();
    connectivityController = StreamController<ConnectivityResult>();
    connectivityService = ConnectivityServiceStub(connectivityController);
    viewModel = ConnectivityViewModel(
      stateController: stateController,
      connectivityService: connectivityService,
    );
  });

  tearDown(() {
    connectivityController.close();
    stateController.close();
  });

  group("Given a ConnectivityViewModel", () {
    group("when stateStream is called", () {
      test("then the stream from the given stateStream is retrieved", () {
        final actual = viewModel.stateStream;
        expect(actual, stateController.stream);
      });
    });

    group("when initialState is called", () {
      test("then an Unknown state is returned", () {
        final actual = viewModel.initialState;
        expect(actual, isA<Unknown>());
      });
    });

    group("when ConnectivityResult.none retrieved from connectivityStream", () {
      group("when dispose is called", () {
        test("then stateController is closed", () {
          viewModel.init();
          expect(stateController.isClosed, false);
          viewModel.dispose();
          expect(stateController.isClosed, true);
        });
      });

      test("then a NoConnection state is added to the state stream", () async {
        stateController.stream.listen((event) {
          expectLater(event, isA<NoConnection>());
        });
        viewModel.init();
        connectivityController.sink.add(ConnectivityResult.none);
      });
    });

    group("when ConnectivityResult.mobile comes from connectivityStream", () {
      test("then a NoConnection state is added to the state stream", () async {
        stateController.stream.listen((event) {
          expectLater(event, isA<Connected>());
        });
        viewModel.init();
        connectivityController.sink.add(ConnectivityResult.mobile);
      });
    });

    group("when ConnectivityResult.wifi retrieved from connectivityStream", () {
      test("then a NoConnection state is added to the state stream", () async {
        stateController.stream.listen((event) {
          expectLater(event, isA<Connected>());
        });
        viewModel.init();
        connectivityController.sink.add(ConnectivityResult.wifi);
      });
    });
  });
}
