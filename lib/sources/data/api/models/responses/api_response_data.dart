import 'package:colored/sources/common/extensions/map_safe_access.dart';

class ApiResponseData {
  const ApiResponseData({
    required this.kind,
    required this.currentItemCount,
    required this.itemsPerPage,
    required this.startIndex,
    required this.totalItems,
    required this.pageIndex,
    required this.totalPages,
    required this.selfUri,
    required this.items,
  });

  static ApiResponseData? fromJson(Map<String, dynamic> json) {
    final kind = json.valueFor<String>(_Key.kind.value);
    final currentItemCount = json.valueFor<int>(_Key.currentItemCount.value);
    final itemsPerPage = json.valueFor<int>(_Key.itemsPerPage.value);
    final startIndex = json.valueFor<int>(_Key.startIndex.value);
    final totalItems = json.valueFor<int>(_Key.totalItems.value);
    final pageIndex = json.valueFor<int>(_Key.pageIndex.value);
    final totalPages = json.valueFor<int>(_Key.totalPages.value);
    final selfUriString = json.stringValueFor(_Key.selfUri.value);
    final selfUri = Uri.parse(selfUriString);
    final items = json.listValueFor<Map<String, dynamic>>(_Key.items.value);
    if (kind == null ||
        currentItemCount == null ||
        itemsPerPage == null ||
        startIndex == null ||
        totalItems == null ||
        pageIndex == null ||
        totalPages == null) {
      return null;
    }
    return ApiResponseData(
      kind: kind,
      currentItemCount: currentItemCount,
      itemsPerPage: itemsPerPage,
      startIndex: startIndex,
      totalItems: totalItems,
      pageIndex: pageIndex,
      totalPages: totalPages,
      selfUri: selfUri,
      items: items,
    );
  }

  final String kind;
  final int currentItemCount;
  final int itemsPerPage;
  final int startIndex;
  final int totalItems;
  final int pageIndex;
  final int totalPages;
  final Uri? selfUri;
  final List<Map<String, dynamic>> items;
}

enum _Key {
  kind,
  currentItemCount,
  itemsPerPage,
  startIndex,
  totalItems,
  pageIndex,
  totalPages,
  selfUri,
  items,
}

extension _KeyValues on _Key {
  String get value {
    switch (this) {
      case _Key.kind:
        return "kind";
      case _Key.currentItemCount:
        return "currentItemCount";
      case _Key.itemsPerPage:
        return "itemsPerPage";
      case _Key.startIndex:
        return "startIndex";
      case _Key.totalItems:
        return "totalItems";
      case _Key.pageIndex:
        return "pageIndex";
      case _Key.totalPages:
        return "totalPages";
      case _Key.selfUri:
        return "selfLink";
      case _Key.items:
        return "items";
    }
  }
}
