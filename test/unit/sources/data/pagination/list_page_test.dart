import 'package:colored/sources/data/api/models/responses/api_response_data.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestItem {
  const _TestItem(this.value);

  factory _TestItem.fromJson(Map<String, dynamic> json) => _TestItem(json[key]);

  static const key = "key";

  final String value;

  @override
  bool operator ==(Object other) => other is _TestItem && other.value == value;

  @override
  int get hashCode => Object.hashAll([value]);
}

void main() {
  const testData = {
    "kind": "test",
    "currentItemCount": 3,
    "itemsPerPage": 10,
    "startIndex": 1,
    "totalItems": 3,
    "pageIndex": 1,
    "totalPages": 1,
    "selfLink": "https://test.com/",
    "items": [
      {_TestItem.key: "value"}
    ]
  };

  group("Given a $ListPage", () {
    group("when constructed from an $ApiResponseData", () {
      test("then values are correctly parsed", () {
        final apiResponseData = ApiResponseData.fromJson(testData);
        if (apiResponseData == null) {
          fail("$ApiResponseData parsing failed, expected not null response.");
        }
        final listPage = ListPage<_TestItem>.fromApiResponseData(
          apiResponseData,
          jsonParser: (json) => _TestItem.fromJson(json),
        );
        expect(listPage.currentItemCount, 3);
        expect(listPage.itemsPerPage, 10);
        expect(listPage.startIndex, 1);
        expect(listPage.totalItems, 3);
        expect(listPage.pageIndex, 1);
        expect(listPage.totalPages, 1);
        expect(listPage.items, [const _TestItem("value")]);
      });
    });

    group("when checking if there is a next page", () {
      group("with a zero start index", () {
        test("then returns true if there are more pages", () {
          const testListPage = ListPage<int>(
            currentItemCount: 2,
            itemsPerPage: 2,
            startIndex: 0,
            totalItems: 4,
            pageIndex: 0,
            totalPages: 2,
            items: [0, 1, 2, 3],
          );
          expect(testListPage.hasNext, isTrue);
        });

        test("then returns false if we are on the last page", () {
          const testListPage = ListPage<int>(
            currentItemCount: 2,
            itemsPerPage: 2,
            startIndex: 0,
            totalItems: 4,
            pageIndex: 1,
            totalPages: 2,
            items: [0, 1, 2, 3],
          );
          expect(testListPage.hasNext, isFalse);
        });

        test("then returns false if we are past the last page", () {
          const testListPage = ListPage<int>(
            currentItemCount: 2,
            itemsPerPage: 2,
            startIndex: 0,
            totalItems: 4,
            pageIndex: 3,
            totalPages: 2,
            items: [0, 1, 2, 3],
          );
          expect(testListPage.hasNext, isFalse);
        });
      });

      group("with a start index == 1", () {
        test("then returns page index is below the start index", () {
          const testListPage = ListPage<int>(
            currentItemCount: 2,
            itemsPerPage: 2,
            startIndex: 1,
            totalItems: 4,
            pageIndex: 0,
            totalPages: 2,
            items: [0, 1, 2, 3],
          );
          expect(testListPage.hasNext, isTrue);
        });

        test("then returns true if there are more pages", () {
          const testListPage = ListPage<int>(
            currentItemCount: 2,
            itemsPerPage: 2,
            startIndex: 1,
            totalItems: 4,
            pageIndex: 1,
            totalPages: 2,
            items: [0, 1, 2, 3],
          );
          expect(testListPage.hasNext, isTrue);
        });

        test("then returns false if we are on the last page", () {
          const testListPage = ListPage<int>(
            currentItemCount: 2,
            itemsPerPage: 2,
            startIndex: 1,
            totalItems: 4,
            pageIndex: 2,
            totalPages: 2,
            items: [0, 1, 2, 3],
          );
          expect(testListPage.hasNext, isFalse);
        });

        test("then returns false if we are past the last page", () {
          const testListPage = ListPage<int>(
            currentItemCount: 2,
            itemsPerPage: 2,
            startIndex: 1,
            totalItems: 4,
            pageIndex: 3,
            totalPages: 2,
            items: [0, 1, 2, 3],
          );
          expect(testListPage.hasNext, isFalse);
        });
      });

      group("with a start index > 1", () {
        test("then returns page index is below the start index", () {
          const testListPage = ListPage<int>(
            currentItemCount: 2,
            itemsPerPage: 2,
            startIndex: 2,
            totalItems: 4,
            pageIndex: 0,
            totalPages: 2,
            items: [0, 1],
          );
          expect(testListPage.hasNext, isTrue);
        });

        test("then returns true if there are more pages", () {
          const testListPage = ListPage<int>(
            currentItemCount: 2,
            itemsPerPage: 2,
            startIndex: 2,
            totalItems: 4,
            pageIndex: 2,
            totalPages: 2,
            items: [0, 1],
          );
          expect(testListPage.hasNext, isTrue);
        });

        test("then returns false if we are on the last page", () {
          const testListPage = ListPage<int>(
            currentItemCount: 2,
            itemsPerPage: 2,
            startIndex: 2,
            totalItems: 4,
            pageIndex: 3,
            totalPages: 2,
            items: [0, 1],
          );
          expect(testListPage.hasNext, isFalse);
        });

        test("then returns false if we are past the last page", () {
          const testListPage = ListPage<int>(
            currentItemCount: 2,
            itemsPerPage: 2,
            startIndex: 2,
            totalItems: 4,
            pageIndex: 8,
            totalPages: 2,
            items: [0, 1],
          );
          expect(testListPage.hasNext, isFalse);
        });
      });
    });

    group("when getting its $PageInfo field", () {
      test("then the page info has the expected values", () {
        const testListPage = ListPage<int>(
          currentItemCount: 0,
          itemsPerPage: 2,
          startIndex: 2,
          totalItems: 4,
          pageIndex: 8,
          totalPages: 2,
          items: [],
        );
        const expected = PageInfo(startIndex: 2, size: 2, pageIndex: 8);
        expect(testListPage.pageInfo, expected);
      });
    });
  });

  group("Given two $ListPage", () {
    group("when checking for equality", () {
      test("two $ListPage are equal if their content is equal", () {
        const firstListPage = ListPage<int>(
          currentItemCount: 0,
          itemsPerPage: 2,
          startIndex: 2,
          totalItems: 4,
          pageIndex: 8,
          totalPages: 2,
          items: [1],
        );
        const secondListPage = ListPage<int>(
          currentItemCount: 0,
          itemsPerPage: 2,
          startIndex: 2,
          totalItems: 4,
          pageIndex: 8,
          totalPages: 2,
          items: [1],
        );
        expect(firstListPage, secondListPage);
      });
    });

    group("when hashCode is called", () {
      test("then all properties are taken into account", () {
        const listPage = ListPage<int>(
          currentItemCount: 1,
          itemsPerPage: 1,
          startIndex: 1,
          totalItems: 1,
          pageIndex: 1,
          totalPages: 1,
          items: [1],
        );
        expect(
          listPage.hashCode,
          Object.hashAll([
            listPage.items,
            listPage.currentItemCount,
            listPage.itemsPerPage,
            listPage.startIndex,
            listPage.totalItems,
            listPage.totalPages,
            listPage.pageIndex,
          ]),
        );
      });
    });
  });
}
