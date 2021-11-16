import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';

abstract class PaginatedSuggestionsService<T> {
  Future<ListPage<T>?> fetchRandom({required PageInfo pageInfo});
}
