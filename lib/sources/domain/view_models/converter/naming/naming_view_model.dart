import 'dart:async';

import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_state.dart';

const _kStartIndex = 1;

const _kPageInfo = PageInfo(
  startIndex: _kStartIndex,
  size: _kStartIndex,
  pageIndex: _kStartIndex,
);

class NamingViewModel {
  NamingViewModel({
    required StreamController<NamingState> stateController,
    required PaginatedNamesService<NamedColor> namingService,
    required Converter converter,
  })  : _namingService = namingService,
        _converter = converter,
        _stateController = stateController;

  final StreamController<NamingState> _stateController;
  final PaginatedNamesService<NamedColor> _namingService;
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

    final page = await _namingService.fetchContainingSearch(
      hexColor.replaceAll("#", ""),
      pageInfo: _kPageInfo,
    );
    if (page != null) {
      _stateController.sink.add(Named(page.items.first.name));
    } else {
      _stateController.sink.add(const Unknown());
    }
  }

  void dispose() => _stateController.close();
}
