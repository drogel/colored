import 'dart:async';

import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/suggestions/paginated_suggestions_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/color_suggestions_state.dart';

const _kSuggestionsLength = 20;
const _kStartIndex = 1;

const _kPageInfo = PageInfo(
  startIndex: _kStartIndex,
  size: _kSuggestionsLength,
  pageIndex: _kStartIndex,
);

class ColorSuggestionsViewModel {
  const ColorSuggestionsViewModel({
    required StreamController<ColorSuggestionsState> stateController,
    required PaginatedSuggestionsService<NamedColor> suggestionsService,
  })  : _stateController = stateController,
        _suggestionsService = suggestionsService;

  final StreamController<ColorSuggestionsState> _stateController;
  final PaginatedSuggestionsService<NamedColor> _suggestionsService;

  Stream<ColorSuggestionsState> get stateStream => _stateController.stream;

  ColorSuggestionsState get initialState => const Loading();

  Future<void> init() async {
    final page = await _suggestionsService.fetchRandom(pageInfo: _kPageInfo);
    if (page == null || page.items.isEmpty) {
      _stateController.sink.add(const Failed());
    } else {
      _stateController.sink.add(ColorSuggestionsFound(page.items));
    }
  }

  void dispose() => _stateController.close();
}
