import 'dart:async';

import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/suggestions/paginated_suggestions_service.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_state.dart';

const _kSuggestionsLength = 20;
const _kStartIndex = 1;

const _kPageInfo = PageInfo(
  startIndex: _kStartIndex,
  size: _kSuggestionsLength,
  pageIndex: _kStartIndex,
);

class PaletteSuggestionsViewModel {
  const PaletteSuggestionsViewModel({
    required StreamController<PaletteSuggestionsState> stateController,
    required PaginatedSuggestionsService<Palette> suggestionsService,
  })  : _stateController = stateController,
        _suggestionsService = suggestionsService;

  final StreamController<PaletteSuggestionsState> _stateController;
  final PaginatedSuggestionsService<Palette> _suggestionsService;

  Stream<PaletteSuggestionsState> get stateStream => _stateController.stream;

  PaletteSuggestionsState get initialState => const Loading();

  Future<void> init() async {
    final page = await _suggestionsService.fetchRandom(pageInfo: _kPageInfo);
    if (page == null || page.items.isEmpty) {
      _stateController.sink.add(const Failed());
    } else {
      _stateController.sink.add(PaletteSuggestionsFound(page.items));
    }
  }

  void dispose() => _stateController.close();
}
