import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/suggestions/paginated_suggestions_service.dart';
import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';

abstract class LocalPaginatedSuggestionsService<I, O>
    implements PaginatedSuggestionsService<O> {
  const LocalPaginatedSuggestionsService({
    required SuggestionsService<I> suggestionsService,
  }) : _service = suggestionsService;

  final SuggestionsService<I> _service;

  O convertEntry(MapEntry<String, I> entry);

  @override
  Future<ListPage<O>?> fetchRandom({required PageInfo pageInfo}) async {
    final suggestionsMap = await _service.fetchSuggestions(pageInfo.size);
    final items = suggestionsMap.entries.map(convertEntry).toList();
    return ListPage.singlePageFromItems(items);
  }
}
