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
    final namedColors = suggestionsMap.entries.map(convertEntry).toList();
    final itemCount = namedColors.length;
    return ListPage(
      currentItemCount: itemCount,
      itemsPerPage: itemCount,
      startIndex: 1,
      totalItems: itemCount,
      pageIndex: 1,
      totalPages: 1,
      items: namedColors,
    );
  }
}
