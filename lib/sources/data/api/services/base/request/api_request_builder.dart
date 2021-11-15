import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';

abstract class ApiRequestBuilder<T> {
  Future<ListPage<T>?> request(
    Iterable<String> queryParameters, {
    required PageInfo pageInfo,
  });
}
