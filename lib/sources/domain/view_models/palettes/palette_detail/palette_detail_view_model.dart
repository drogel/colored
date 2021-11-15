import 'dart:async';

import 'package:colored/sources/data/api/services/base/request/api_request_builder.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';

class PaletteDetailViewModel {
  const PaletteDetailViewModel({
    required StreamController<PaletteDetailState> stateController,
    required ApiRequestBuilder<NamedColor> paletteNamingService,
  })  : _namingService = paletteNamingService,
        _stateController = stateController;

  final StreamController<PaletteDetailState> _stateController;
  final ApiRequestBuilder<NamedColor> _namingService;

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
	final cleanHexes = hexCodes.map((c) => c.replaceAll("#", "")).toList();
    final pageSize = cleanHexes.length;
    final pageInfo = PageInfo(startIndex: 1, size: pageSize, pageIndex: 1);
    final page = await _namingService.request(cleanHexes, pageInfo: pageInfo);
    if (page != null) {
      _stateController.sink.add(PaletteFound(page.items, name));
    } else {
      _stateController.sink.add(Failed(name));
    }
  }

  void dispose() => _stateController.close();
}
