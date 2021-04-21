import 'package:colored/sources/domain/data_models/data_wrapper.dart';
import 'package:colored/sources/domain/data_models/items_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DataWrapper<int>? testWrapper;
  List<int>? testItems;

  setUp(() {
    testItems = [1, 2, 3, 4];
    testWrapper = DataWrapper(data: ItemsWrapper<int>(items: testItems));
  });

  tearDown(() {
    testItems = null;
    testWrapper = null;
  });

  group("Given an DataWrapper", () {
    group("when comparing two DataWrappers", () {
      test("then they are different if they have different items", () {
        const anotherWrapper = DataWrapper(
          data: ItemsWrapper<int>(items: [1, 2, 3]),
        );
        expect(anotherWrapper, isNot(testWrapper));
      });
    });

    group("when building an DataWrapper from a map", () {
      test("then an DataWrapper object is built from the map", () {
        final testMap = {
          "apiVersion": "1",
          "method": "GET",
          "data": {
            "items": testItems,
          },
        };

        final actualWrapper = DataWrapper<int>.fromMap(
          testMap,
          ItemsWrapper<int>(items: testItems),
        );

        expect(actualWrapper.apiVersion, testMap["apiVersion"]);
        expect(actualWrapper.method, testMap["method"]);
        expect(actualWrapper.data, ItemsWrapper<int>(items: testItems));
      });

      test("then items not found in map are null", () {
        final testMap = {
          "apiVersion": "1",
          "data": {
            "items": testItems,
          },
        };

        final actualWrapper = DataWrapper<int>.fromMap(
          testMap,
          ItemsWrapper<int>(items: testItems),
        );

        expect(actualWrapper.method, isNull);
      });
    });
  });
}
