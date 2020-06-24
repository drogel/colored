import 'dart:async';

import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/naming/naming_service.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/naming/naming_state.dart';
import 'package:flutter/foundation.dart';

import 'naming_state.dart';

class NamingViewModel {
  NamingViewModel({
    @required StreamController<NamingState> stateController,
    @required NamingService namingService,
    @required Converter converter,
  })  : assert(stateController != null),
        assert(namingService != null),
        assert(converter != null),
        _namingService = namingService,
        _converter = converter,
        _stateController = stateController;

  final StreamController<NamingState> _stateController;
  final NamingService _namingService;
  final Converter _converter;

  Stream<NamingState> get stateStream => _stateController.stream;

  NamingState get initialData => const Unknown();

  Future<void> fetchNaming(ColorSelection selection) async {
    _stateController.sink.add(const Changing());

    final r = (selection.r * decimal8Bit).round();
    final g = (selection.g * decimal8Bit).round();
    final b = (selection.b * decimal8Bit).round();

    final hexColor = _converter.convert(r, g, b)[Format.hex];
    final namingResult = await _namingService.getNaming(hexColor: hexColor);

    if (namingResult.response == ResponseStatus.ok) {
      _stateController.sink.add(Named(namingResult.result.name));
    } else {
      _stateController.sink.add(const Unknown());
    }
  }

  void dispose() => _stateController.close();
}
