import 'dart:async';

import 'package:colored/sources/data/services/connectivity/connectivity_service.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_state.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_view_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';

class ConnectivityServiceStub implements ConnectivityService {
  const ConnectivityServiceStub(this.connectivityController);

  final StreamController<ConnectivityResult> connectivityController;

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      connectivityController.stream;
}

void main() {
  ConnectivityViewModel viewModel;
  StreamController<ConnectivityState> stateController;
  StreamController<ConnectivityResult> connectivityController;
  ConnectivityService connectivityService;

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
    connectivityController = null;
    stateController.close();
    stateController = null;
    connectivityService = null;
    viewModel = null;
  });

  group("Given a ConnectivityViewModel", () {
    group("when ConnectivityResult.none retrieved from connectivityStream", () {
      test("then a NoConnection state is added to the state stream", () async {
        stateController.stream.listen((event) {
          expectLater(event.runtimeType, NoConnection);
        });
        viewModel.init();
        connectivityController.sink.add(ConnectivityResult.none);
      });
    });

    group("when ConnectivityResult.mobile comes from connectivityStream", () {
      test("then a NoConnection state is added to the state stream", () async {
        stateController.stream.listen((event) {
          expectLater(event.runtimeType, Connected);
        });
        viewModel.init();
        connectivityController.sink.add(ConnectivityResult.mobile);
      });
    });

    group("when ConnectivityResult.wifi retrieved from connectivityStream", () {
      test("then a NoConnection state is added to the state stream", () async {
        stateController.stream.listen((event) {
          expectLater(event.runtimeType, Connected);
        });
        viewModel.init();
        connectivityController.sink.add(ConnectivityResult.wifi);
      });
    });
  });
}
