import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';

abstract class PaginatedNamesService<T> {
  Future<ListPage<T>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  });
}
