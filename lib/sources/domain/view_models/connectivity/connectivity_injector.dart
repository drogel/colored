import 'dart:async';

import 'package:colored/sources/data/services/connectivity/device_connectivity_service.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_state.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_view_model.dart';

class ConnectivityInjector {
  const ConnectivityInjector();

  ConnectivityViewModel injectViewModel([
    StreamController<ConnectivityState> stateController,
  ]) =>
      ConnectivityViewModel(
        stateController:
            stateController ?? StreamController<ConnectivityState>(),
        connectivityService: DeviceConnectivityService(),
      );
}
