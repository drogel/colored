import 'package:colored/sources/data/api/models/responses/api_response_data.dart';

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

  final int currentItemCount;
  final int itemsPerPage;
  final int startIndex;
  final int totalItems;
  final int pageIndex;
  final int totalPages;
  final List<T> items;
}
