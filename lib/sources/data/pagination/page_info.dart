import 'package:vector_math/hash.dart';

class PageInfo {
  const PageInfo({
    required this.startIndex,
    required this.size,
    required this.pageIndex,
  });

  static String startIndexKey = _Key.startIndex.value;
  static String sizeKey = _Key.size.value;
  static String pageIndexKey = _Key.pageIndex.value;

  final int startIndex;
  final int size;
  final int pageIndex;

  PageInfo get next => PageInfo(
        startIndex: startIndex,
        size: size,
        pageIndex: pageIndex + 1,
      );

  @override
  bool operator ==(Object other) =>
      other is PageInfo &&
      other.startIndex == startIndex &&
      other.size == size &&
      other.pageIndex == pageIndex;

  @override
  int get hashCode => hashObjects([startIndex, size, pageIndex]);
}

enum _Key {
  startIndex,
  size,
  pageIndex,
}

extension _KeyValues on _Key {
  String get value {
    switch (this) {
      case _Key.startIndex:
        return "startIndex";
      case _Key.size:
        return "size";
      case _Key.pageIndex:
        return "page";
    }
  }
}
