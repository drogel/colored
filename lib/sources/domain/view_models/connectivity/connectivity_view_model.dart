import 'dart:async';

import 'package:colored/sources/data/services/connectivity/connectivity_service.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

class ConnectivityViewModel {
  ConnectivityViewModel({
    @required StreamController<ConnectivityState> stateController,
    @required ConnectivityService connectivityService,
  })  : assert(stateController != null),
        assert(connectivityService != null),
        _connectivityService = connectivityService,
        _stateController = stateController;

  final StreamController<ConnectivityState> _stateController;
  final ConnectivityService _connectivityService;

  StreamSubscription<ConnectivityResult> _subscription;

  Stream<ConnectivityState> get stateStream => _stateController.stream;

  ConnectivityState get initialData => const Unknown();

  void init() {
    final stream = _connectivityService.onConnectivityChanged;
    _subscription = stream.listen(_onConnectivityChanged);
  }

  void dispose() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
    _stateController.close();
  }

  void _onConnectivityChanged(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      return _stateController.sink.add(const NoConnection());
    } else {
      return _stateController.sink.add(const Connected());
    }
  }
}
