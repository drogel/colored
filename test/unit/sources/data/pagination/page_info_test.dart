import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:flutter_test/flutter_test.dart';

const int _kStartIndex = 1;
const int _kSize = 10;
const int _kPageIndex = 1;

void main() {
  late PageInfo pageInfo;

  group("Given a valid $PageInfo", () {
    setUp(() => pageInfo = const PageInfo(
          startIndex: _kStartIndex,
          size: _kSize,
          pageIndex: _kPageIndex,
        ));

    group("when constructed", () {
      test("then startIndex can be accessed", () {
        expect(pageInfo.startIndex, _kStartIndex);
      });

      test("then size can be accessed", () {
        expect(pageInfo.size, _kSize);
      });

      test("then pageIndex can be accessed", () {
        expect(pageInfo.pageIndex, _kPageIndex);
      });
    });

    group("when hashCode is called", () {
      test("then the hashCode is built based on all fields", () {
        expect(
          pageInfo.hashCode,
          Object.hashAll([_kStartIndex, _kSize, _kPageIndex]),
        );
      });
    });

    group("when next is called", () {
      test("then the returned pageInfo has the index of the next page", () {
        const nextPageInfo = PageInfo(
          startIndex: _kStartIndex,
          size: _kSize,
          pageIndex: _kPageIndex + 1,
        );
        expect(pageInfo.next, nextPageInfo);
      });
    });
  });

  group("Given two valid $PageInfo", () {
    late PageInfo otherPageInfo;

    setUp(() => pageInfo = const PageInfo(
          startIndex: _kStartIndex,
          size: _kSize,
          pageIndex: _kPageIndex,
        ));

    group("when compared", () {
      test("pageInfos are equal if they have the same fields", () {
        otherPageInfo = const PageInfo(
          startIndex: _kStartIndex,
          size: _kSize,
          pageIndex: _kPageIndex,
        );
        expect(otherPageInfo == pageInfo, isTrue);
      });

      test("pageInfos are not equal if they don't have same startIndex", () {
        otherPageInfo = const PageInfo(
          startIndex: _kStartIndex + 1,
          size: _kSize,
          pageIndex: _kPageIndex,
        );
        expect(otherPageInfo == pageInfo, isFalse);
      });

      test("pageInfos are not equal if they don't have same size", () {
        otherPageInfo = const PageInfo(
          startIndex: _kStartIndex,
          size: _kSize + 1,
          pageIndex: _kPageIndex,
        );
        expect(otherPageInfo == pageInfo, isFalse);
      });

      test("pageInfos are not equal if they don't have same pageIndex", () {
        otherPageInfo = const PageInfo(
          startIndex: _kStartIndex,
          size: _kSize,
          pageIndex: _kPageIndex + 1,
        );
        expect(otherPageInfo == pageInfo, isFalse);
      });
    });
  });
}
