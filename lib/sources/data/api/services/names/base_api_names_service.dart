import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';

class BasePaginatedNamesService<O> implements PaginatedNamesService<O> {
  @override
  Future<ListPage<O>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) {
    // TODO: implement fetchContainingSearch
    throw UnimplementedError();
  }
}
