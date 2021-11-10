import 'package:colored/sources/data/pagination/page_info.dart';

abstract class PageRequestBuilder {
  Uri addPageParameters(Uri uri, {required PageInfo pageInfo});
}
