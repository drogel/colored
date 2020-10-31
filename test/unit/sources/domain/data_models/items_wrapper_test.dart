import 'package:colored/sources/domain/data_models/items_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ItemsWrapper<int> testWrapper;
  List<int> testItems;

  setUp(() {
    testItems = [1, 2, 3, 4];
    testWrapper = ItemsWrapper(items: testItems);
  });

  tearDown(() {
    testItems = null;
    testWrapper = null;
  });

  group("Given an ItemWrapper", () {
    group("when comparing two ItemWrappers", () {
      test("then they are different if they have different items", () {
        const anotherWrapper = ItemsWrapper<int>(items: [1, 2, 3]);
        expect(anotherWrapper, isNot(testWrapper));
      });
    });

    group("when building an ItemWrapper from a map", () {
      test("then an ItemWrapper object is built from the map", () {
        final testMap = {
          "kind": "color",
          "currentItemCount": 20,
          "itemsPerPage": 20,
          "startIndex": 1,
          "totalItems": 267,
          "pageIndex": 1,
          "totalPages": 14,
          "nextLink": "nextLink",
          "selfLink": "selfLink",
          "previousLink": "previousLink",
          "items": testItems,
        };

        final actualWrapper = ItemsWrapper<int>.fromMap(testMap, testItems);

        expect(actualWrapper.kind, testMap["kind"]);
        expect(actualWrapper.currentItemCount, testMap["currentItemCount"]);
        expect(actualWrapper.itemsPerPage, testMap["itemsPerPage"]);
        expect(actualWrapper.startIndex, testMap["startIndex"]);
        expect(actualWrapper.totalItems, testMap["totalItems"]);
        expect(actualWrapper.nextLink, testMap["nextLink"]);
        expect(actualWrapper.previousLink, testMap["previousLink"]);
        expect(actualWrapper.items, testMap["items"]);
      });

      test("then items not found in map are null", () {
        final testMap = {
          "kind": "color",
          "currentItemCount": 20,
          "itemsPerPage": 20,
          "startIndex": 1,
          "totalItems": 267,
          "pageIndex": 1,
          "totalPages": 14,
          "selfLink": "selfLink",
          "items": testItems,
        };

        final actualWrapper = ItemsWrapper<int>.fromMap(testMap, testItems);

        expect(actualWrapper.nextLink, isNull);
        expect(actualWrapper.previousLink, isNull);
      });
    });
  });
}
