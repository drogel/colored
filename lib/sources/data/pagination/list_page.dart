import 'package:collection/collection.dart';
import 'package:colored/sources/data/api/models/responses/api_response_data.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:vector_math/hash.dart';

typedef JsonParser<T> = T Function(Map<String, dynamic> json);

class ListPage<T> {
  const ListPage({
    required this.currentItemCount,
    required this.itemsPerPage,
    required this.startIndex,
    required this.totalItems,
    required this.pageIndex,
    required this.totalPages,
    required this.items,
  });

  factory ListPage.fromApiResponseData(
    ApiResponseData apiResponseData, {
    required JsonParser<T> jsonParser,
  }) {
    final items = apiResponseData.items.map(jsonParser).toList();
    return ListPage<T>(
      currentItemCount: apiResponseData.currentItemCount,
      itemsPerPage: apiResponseData.itemsPerPage,
      startIndex: apiResponseData.startIndex,
      totalItems: apiResponseData.totalItems,
      pageIndex: apiResponseData.pageIndex,
      totalPages: apiResponseData.totalPages,
      items: items,
    );
  }

  factory ListPage.singlePageFromItems(List<T> items) => ListPage(
        currentItemCount: items.length,
        itemsPerPage: items.length,
        startIndex: 1,
        totalItems: items.length,
        pageIndex: 1,
        totalPages: 1,
        items: items,
      );

  final int currentItemCount;
  final int itemsPerPage;
  final int startIndex;
  final int totalItems;
  final int pageIndex;
  final int totalPages;
  final List<T> items;

  bool get hasNext => pageIndex - startIndex < totalPages - 1;

  PageInfo get pageInfo => PageInfo(
        startIndex: startIndex,
        size: itemsPerPage,
        pageIndex: pageIndex,
      );

  @override
  bool operator ==(Object other) =>
      other is ListPage<T> &&
      const ListEquality().equals(items, other.items) &&
      other.currentItemCount == currentItemCount &&
      other.itemsPerPage == itemsPerPage &&
      other.startIndex == startIndex &&
      other.totalItems == totalItems &&
      other.totalPages == totalPages &&
      other.pageIndex == pageIndex;

  @override
  int get hashCode => hashObjects([
        items,
        currentItemCount,
        itemsPerPage,
        startIndex,
        totalItems,
        totalPages,
        pageIndex,
      ]);
}
