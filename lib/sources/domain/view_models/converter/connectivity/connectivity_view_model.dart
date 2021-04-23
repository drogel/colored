import 'dart:async';

import 'package:colored/sources/data/services/connectivity/connectivity_service.dart';
import 'package:colored/sources/domain/view_models/converter/connectivity/connectivity_state.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityViewModel {
  ConnectivityViewModel({
    required StreamController<ConnectivityState> stateController,
    required ConnectivityService connectivityService,
  })   : _connectivityService = connectivityService,
        _stateController = stateController;

  final StreamController<ConnectivityState> _stateController;
  final ConnectivityService _connectivityService;

  late final StreamSubscription<ConnectivityResult> _subscription;

  Stream<ConnectivityState> get stateStream => _stateController.stream;

  ConnectivityState get initialState => const Unknown();

  void init() {
    final stream = _connectivityService.onConnectivityChanged;
    _subscription = stream.listen(_onConnectivityChanged);
  }

  void dispose() {
    _subscription.cancel();
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
