import 'package:colored/sources/data/api/models/responses/api_response_data.dart';
import 'package:flutter_test/flutter_test.dart';

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
      {"testKey": "testValue"}
    ]
  };

  group("Given an $ApiResponseData", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        final apiResponseData = ApiResponseData.fromJson(testData);
        if (apiResponseData == null) {
          fail("$ApiResponseData parsing failed, expected not null response.");
        }
        expect(apiResponseData.kind, "test");
        expect(apiResponseData.currentItemCount, 3);
        expect(apiResponseData.itemsPerPage, 10);
        expect(apiResponseData.startIndex, 1);
        expect(apiResponseData.totalItems, 3);
        expect(apiResponseData.pageIndex, 1);
        expect(apiResponseData.totalPages, 1);
        expect(apiResponseData.selfUri.toString(), "https://test.com/");
        expect(apiResponseData.items, [
          {"testKey": "testValue"}
        ]);
      });
    });
  });
}
