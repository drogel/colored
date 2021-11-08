import 'package:vector_math/hash.dart';

class PageInfo {
  const PageInfo({
    required this.startIndex,
    required this.size,
    required this.pageIndex,
  });

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
