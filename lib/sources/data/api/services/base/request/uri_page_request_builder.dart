import 'package:colored/sources/data/api/services/base/request/page_request_builder.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/common/extensions/uri_copy.dart';

class UriPageRequestBuilder implements PageRequestBuilder {
  const UriPageRequestBuilder();

  @override
  Uri addPageParameters(Uri uri, {required PageInfo pageInfo}) {
    final uriRequestQueryParameters = uri.queryParameters;
    final requestQueryParameters = {
      PageInfo.sizeKey: pageInfo.size.toString(),
      PageInfo.pageIndexKey: pageInfo.pageIndex.toString(),
    };
    requestQueryParameters.addAll(uriRequestQueryParameters);
    return uri.copy(queryParameters: requestQueryParameters);
  }
}
