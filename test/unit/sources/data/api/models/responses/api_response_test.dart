import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/network_client/http_method.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testResponse = {
    "apiVersion": "test",
    "method": "GET",
    "data": {
      "kind": "testKind",
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
    }
  };

  group("Given an $ApiResponse", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        final apiResponse = ApiResponse.fromJson(testResponse);
        if (apiResponse == null) {
          fail("$ApiResponse");
        }
        expect(apiResponse.apiVersion, "test");
        expect(apiResponse.method, HttpMethod.get);
        expect(apiResponse.data.kind, "testKind");
        expect(apiResponse.data.currentItemCount, 3);
        expect(apiResponse.data.itemsPerPage, 10);
        expect(apiResponse.data.startIndex, 1);
        expect(apiResponse.data.totalItems, 3);
        expect(apiResponse.data.pageIndex, 1);
        expect(apiResponse.data.totalPages, 1);
        expect(apiResponse.data.selfUri.toString(), "https://test.com/");
        expect(apiResponse.data.items, [
          {"testKey": "testValue"}
        ]);
      });
    });
  });
}
