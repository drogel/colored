import 'package:vector_math/hash.dart';

class ItemsWrapper<T> {
  const ItemsWrapper({
    this.kind,
    this.currentItemCount,
    this.itemsPerPage,
    this.startIndex,
    this.totalItems,
    this.pageIndex,
    this.totalPages,
    this.nextLink,
    this.previousLink,
    this.items,
  });

  factory ItemsWrapper.fromMap(Map<String, dynamic> map, List<T>? items) =>
      ItemsWrapper(
        kind: map["kind"],
        currentItemCount: map["currentItemCount"],
        itemsPerPage: map["itemsPerPage"],
        startIndex: map["startIndex"],
        totalItems: map["totalItems"],
        pageIndex: map["pageIndex"],
        totalPages: map["totalPages"],
        nextLink: map["nextLink"],
        previousLink: map["previousLink"],
        items: items,
      );

  final String? kind;
  final int? currentItemCount;
  final int? itemsPerPage;
  final int? startIndex;
  final int? totalItems;
  final int? pageIndex;
  final int? totalPages;
  final String? nextLink;
  final String? previousLink;
  final List<T>? items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemsWrapper &&
          runtimeType == other.runtimeType &&
          kind == other.kind &&
          currentItemCount == other.currentItemCount &&
          itemsPerPage == other.itemsPerPage &&
          startIndex == other.startIndex &&
          totalItems == other.totalItems &&
          pageIndex == other.pageIndex &&
          totalPages == other.totalPages &&
          nextLink == other.nextLink &&
          previousLink == other.previousLink &&
          items == other.items;

  @override
  int get hashCode {
    final nullFiltered = [
      kind,
      currentItemCount,
      itemsPerPage,
      startIndex,
      totalItems,
      pageIndex,
      totalPages,
      nextLink,
      previousLink,
      items,
    ].map((e) => e ?? 0).toList();
    return hashObjects(nullFiltered);
  }
}
