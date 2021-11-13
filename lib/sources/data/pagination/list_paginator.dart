import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/pagination/paginator.dart';

class ListPaginator<T> implements Paginator<T> {
  const ListPaginator();

  @override
  ListPage<T> paginate(List<T> items, {required PageInfo pageInfo}) {
    final startIndex = pageInfo.startIndex;
    final pageSize = pageInfo.size;
    final pageIndex = pageInfo.pageIndex;
    final sublistStartIndex = _getSublistStartIndex(
      pageIndex: pageIndex,
      pageSize: pageSize,
      startIndex: startIndex,
    );
    final listEndIndex = items.length;
    final sublistEndIndex = _getSublistEndIndex(
      sublistStartIndex: sublistStartIndex,
      pageSize: pageSize,
      listEndIndex: listEndIndex,
    );
    final totalPages = (items.length / pageSize).ceil();
    final sublist = _getSublist(items, sublistStartIndex, sublistEndIndex);
    return ListPage<T>(
      currentItemCount: sublist.length,
      itemsPerPage: pageSize,
      startIndex: startIndex,
      totalItems: items.length,
      pageIndex: pageIndex,
      totalPages: totalPages,
      items: sublist,
    );
  }

  int _getSublistStartIndex({
    required int pageIndex,
    required int pageSize,
    required int startIndex,
  }) {
    if (pageIndex.isNegative) {
      return 0;
    }
    final relativeIndex = (pageIndex - startIndex).clamp(0, pageIndex);
    return pageSize * relativeIndex;
  }

  int _getSublistEndIndex({
    required int sublistStartIndex,
    required int pageSize,
    required int listEndIndex,
  }) {
    final maxSublistStartIndex = sublistStartIndex + pageSize;
    if (sublistStartIndex >= listEndIndex) {
      return listEndIndex;
    }
    return maxSublistStartIndex.clamp(sublistStartIndex, listEndIndex);
  }

  List<T> _getSublist(List<T> list, int startIndex, int endIndex) {
    final isStartValid = !startIndex.isNegative && startIndex <= list.length;
    final isEndValid = !endIndex.isNegative;
    final isRangeValid = isStartValid && isEndValid && startIndex <= endIndex;
    if (!isRangeValid) {
      return [];
    }
    return list.sublist(startIndex, endIndex);
  }
}
