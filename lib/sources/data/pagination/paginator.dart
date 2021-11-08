import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';

abstract class Paginator<T> {
  ListPage<T> paginate(List<T> items, {required PageInfo pageInfo});
}
