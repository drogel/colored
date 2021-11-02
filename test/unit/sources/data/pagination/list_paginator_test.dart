import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/list_paginator.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/pagination/paginator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Paginator<int> paginator;

  List<int> _buildTestItems({required int size}) =>
      List<int>.generate(size, (i) => i);

  void _runPaginatorTest(
    Paginator<int> paginator, {
    required int testItemsSize,
    required int testPageSize,
    required int testStartIndex,
    required int testPageIndex,
    required int actualCurrentItemCount,
    required int actualItemsPerPage,
    required int actualStartIndex,
    required int actualTotalItems,
    required int actualPageIndex,
    required int actualTotalPages,
    required List<int> actualItems,
  }) {
    final pageInfo = PageInfo(
      pageIndex: testPageIndex,
      startIndex: testStartIndex,
      size: testPageSize,
    );
    final testItems = _buildTestItems(size: testItemsSize);
    final actual = paginator.paginate(testItems, pageInfo: pageInfo);
    expect(
      actual.currentItemCount,
      actualCurrentItemCount,
      reason: "actualCurrentItemCount didn't match",
    );
    expect(
      actual.itemsPerPage,
      actualItemsPerPage,
      reason: "actualItemsPerPage didn't match",
    );
    expect(
      actual.startIndex,
      actualStartIndex,
      reason: "actualStartIndex didn't match",
    );
    expect(
      actual.totalItems,
      actualTotalItems,
      reason: "actualTotalItems didn't match",
    );
    expect(
      actual.pageIndex,
      actualPageIndex,
      reason: "actualPageIndex didn't match",
    );
    expect(
      actual.totalPages,
      actualTotalPages,
      reason: "actualTotalPages didn't match",
    );
    expect(
      actual.items,
      actualItems,
      reason: "actualItems didn't match",
    );
  }

  group("Given a $ListPaginator of integers", () {
    setUp(() {
      paginator = const ListPaginator<int>();
    });

    group("when splitting a page smaller than the whole items lenght", () {
      group("with 0 startIndex", () {
        test("then the starting $ListPage has the expected information", () {
          _runPaginatorTest(
            paginator,
            testItemsSize: 10,
            testPageSize: 2,
            testStartIndex: 0,
            testPageIndex: 0,
            actualCurrentItemCount: 2,
            actualItemsPerPage: 2,
            actualStartIndex: 0,
            actualTotalItems: 10,
            actualPageIndex: 0,
            actualTotalPages: 5,
            actualItems: [0, 1],
          );
        });

        test("then a middle $ListPage has the expected information", () {
          _runPaginatorTest(
            paginator,
            testItemsSize: 10,
            testPageSize: 2,
            testStartIndex: 0,
            testPageIndex: 3,
            actualCurrentItemCount: 2,
            actualItemsPerPage: 2,
            actualStartIndex: 0,
            actualTotalItems: 10,
            actualPageIndex: 3,
            actualTotalPages: 5,
            actualItems: [6, 7],
          );
        });

        test("then the ending $ListPage has the expected information", () {
          _runPaginatorTest(
            paginator,
            testItemsSize: 10,
            testPageSize: 2,
            testStartIndex: 0,
            testPageIndex: 4,
            actualCurrentItemCount: 2,
            actualItemsPerPage: 2,
            actualStartIndex: 0,
            actualTotalItems: 10,
            actualPageIndex: 4,
            actualTotalPages: 5,
            actualItems: [8, 9],
          );
        });

        test("then the big ending $ListPage has the expected information", () {
          _runPaginatorTest(
            paginator,
            testItemsSize: 10,
            testPageSize: 3,
            testStartIndex: 0,
            testPageIndex: 3,
            actualCurrentItemCount: 1,
            actualItemsPerPage: 3,
            actualStartIndex: 0,
            actualTotalItems: 10,
            actualPageIndex: 3,
            actualTotalPages: 4,
            actualItems: [9],
          );
        });
      });

      group("with non-zero startIndex", () {
        test("then the starting $ListPage has the expected information", () {
          _runPaginatorTest(
            paginator,
            testItemsSize: 10,
            testPageSize: 2,
            testStartIndex: 2,
            testPageIndex: 2,
            actualCurrentItemCount: 2,
            actualItemsPerPage: 2,
            actualStartIndex: 2,
            actualTotalItems: 10,
            actualPageIndex: 2,
            actualTotalPages: 5,
            actualItems: [0, 1],
          );
        });

        test("then a middle $ListPage has the expected information", () {
          _runPaginatorTest(
            paginator,
            testItemsSize: 10,
            testPageSize: 2,
            testStartIndex: 2,
            testPageIndex: 5,
            actualCurrentItemCount: 2,
            actualItemsPerPage: 2,
            actualStartIndex: 2,
            actualTotalItems: 10,
            actualPageIndex: 5,
            actualTotalPages: 5,
            actualItems: [6, 7],
          );
        });

        test("then the ending $ListPage has the expected information", () {
          _runPaginatorTest(
            paginator,
            testItemsSize: 10,
            testPageSize: 2,
            testStartIndex: 2,
            testPageIndex: 6,
            actualCurrentItemCount: 2,
            actualItemsPerPage: 2,
            actualStartIndex: 2,
            actualTotalItems: 10,
            actualPageIndex: 6,
            actualTotalPages: 5,
            actualItems: [8, 9],
          );
        });

        test("then the big ending $ListPage has the expected information", () {
          _runPaginatorTest(
            paginator,
            testItemsSize: 10,
            testPageSize: 3,
            testStartIndex: 3,
            testPageIndex: 6,
            actualCurrentItemCount: 1,
            actualItemsPerPage: 3,
            actualStartIndex: 3,
            actualTotalItems: 10,
            actualPageIndex: 6,
            actualTotalPages: 4,
            actualItems: [9],
          );
        });
      });
    });

    group("when splitting a page bigger than the whole items lenght", () {
      group("with 0 startIndex", () {
        test("then the only $ListPage has the expected information", () {
          _runPaginatorTest(
            paginator,
            testItemsSize: 3,
            testPageSize: 4,
            testStartIndex: 0,
            testPageIndex: 0,
            actualCurrentItemCount: 3,
            actualItemsPerPage: 4,
            actualStartIndex: 0,
            actualTotalItems: 3,
            actualPageIndex: 0,
            actualTotalPages: 1,
            actualItems: [0, 1, 2],
          );
        });
      });

      group("with non-zero startIndex", () {
        test("then the starting $ListPage has the expected information", () {
          _runPaginatorTest(
            paginator,
            testItemsSize: 3,
            testPageSize: 4,
            testStartIndex: 1,
            testPageIndex: 1,
            actualCurrentItemCount: 3,
            actualItemsPerPage: 4,
            actualStartIndex: 1,
            actualTotalItems: 3,
            actualPageIndex: 1,
            actualTotalPages: 1,
            actualItems: [0, 1, 2],
          );
        });
      });
    });
  });
}
