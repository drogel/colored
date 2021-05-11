import 'dart:async';

import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_service.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';

class PaletteDetailViewModel {
  const PaletteDetailViewModel({
    required StreamController<PaletteDetailState> stateController,
    required PaletteNamingService paletteNamingService,
  })   : _namingService = paletteNamingService,
        _stateController = stateController;

  final StreamController<PaletteDetailState> _stateController;
  final PaletteNamingService _namingService;

  Stream<PaletteDetailState> get stateStream => _stateController.stream;

  PaletteDetailState get initialState => Pending.empty();

  Future<void> fetchColorNames(List<String>? hexCodes, String? name) async {
    if (hexCodes == null || hexCodes.isEmpty) {
      return;
    }
    if (name == null || name.isEmpty) {
      return;
    }

    _stateController.sink.add(Pending(name, hexCodes));
    final response = await _namingService.getNaming(hexColors: hexCodes);
    final results = response.results;
    if (response.status == ResponseStatus.ok && results != null) {
      _stateController.sink.add(PaletteFound(results, name));
    } else {
      _stateController.sink.add(Failed(name));
    }
  }

  void dispose() => _stateController.close();
}
