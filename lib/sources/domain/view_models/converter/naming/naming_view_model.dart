import 'dart:async';

import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/naming/naming_service.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_state.dart';

import 'naming_state.dart';

class NamingViewModel {
  NamingViewModel({
    required StreamController<NamingState> stateController,
    required NamingService namingService,
    required Converter converter,
  })   : _namingService = namingService,
        _converter = converter,
        _stateController = stateController;

  final StreamController<NamingState> _stateController;
  final NamingService _namingService;
  final Converter _converter;

  Stream<NamingState> get stateStream => _stateController.stream;

  NamingState get initialState => const Unknown();

  Future<void> fetchNaming(ColorSelection selection) async {
    _stateController.sink.add(const Changing());

    final r = (selection.r * decimal8Bit).round();
    final g = (selection.g * decimal8Bit).round();
    final b = (selection.b * decimal8Bit).round();

    final hexColor = _converter.convert(r, g, b)[Format.hex];
    if (hexColor == null) {
      return _stateController.sink.add(const Unknown());
    }

    final namingResponse = await _namingService.getNaming(hexColor: hexColor);
    final namingResult = namingResponse.result;
    if (namingResponse.status == ResponseStatus.ok && namingResult != null) {
      _stateController.sink.add(Named(namingResult.name));
    } else {
      _stateController.sink.add(const Unknown());
    }
  }

  void dispose() => _stateController.close();
}
