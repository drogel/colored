import 'dart:async';

import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/format_converter/format_converter.dart';
import 'package:colored/sources/data/services/api_response.dart';
import 'package:colored/sources/data/services/connectivity/connectivity_service.dart';
import 'package:colored/sources/data/services/naming/naming_service.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/naming/naming_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

import 'naming_state.dart';

class NamingViewModel {
  NamingViewModel({
    @required StreamController<NamingState> stateController,
    @required NamingService namingService,
    @required ConnectivityService connectivityService,
    @required FormatConverter converter,
  })  : assert(stateController != null),
        assert(namingService != null),
        assert(connectivityService != null),
        assert(converter != null),
        _namingService = namingService,
        _converter = converter,
        _connectivityService = connectivityService,
        _stateController = stateController;

  final StreamController<NamingState> _stateController;
  final NamingService _namingService;
  final ConnectivityService _connectivityService;
  final FormatConverter _converter;

  StreamSubscription<ConnectivityResult> _connectivity;

  Stream<NamingState> get stateStream => _stateController.stream;

  NamingState get initialData => const Unknown();

  void init() {
    final connectivityStream = _connectivityService.connectivityStream;
    _connectivity = connectivityStream.skip(1).listen(_onConnectivityChanged);
  }

  Future<void> fetchNaming(ColorSelection selection) async {
    final connectivityResult = await _connectivityService.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return;
    }

    _stateController.sink.add(const Changing());

    final r = (selection.first * decimal8Bit).round();
    final g = (selection.second * decimal8Bit).round();
    final b = (selection.third * decimal8Bit).round();

    final hexColor = _converter.convert(r, g, b);
    final namingResult = await _namingService.getNaming(hexColor: hexColor);

    if (namingResult.response == ApiResponse.ok) {
      _stateController.sink.add(Named(namingResult.result.name));
    } else {
      _stateController.sink.add(const Unknown());
    }
  }

  void dispose() {
    _connectivity?.cancel();
    _stateController.close();
  }

  void _onConnectivityChanged(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      return _stateController.sink.add(const NoConnectivity());
    }
  }
}
