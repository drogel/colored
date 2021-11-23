import 'dart:convert';

import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/suggestions/color_suggestions_api_service.dart';
import 'package:colored/sources/data/api/services/suggestions/color_suggestions_search_api_service.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../network_client/test_helpers/http_client_stubs.dart';
import '../../test_helpers/test_api_index_response.dart';

const testPageInfo = PageInfo(startIndex: 1, size: 3, pageIndex: 1);

const testColorSuggestionsApiResponse = {
  "apiVersion": "0.3.0",
  "method": "GET",
  "data": {
    "kind": "color_suggestion",
    "currentItemCount": 3,
    "itemsPerPage": 3,
    "startIndex": 1,
    "totalItems": 3,
    "pageIndex": 1,
    "totalPages": 1,
    "selfLink": "https://test.com/suggestions/colors/search/names?name=black",
    "items": [
      {
        "color": {
          "name": "Test Color",
          "hex": "#000000",
          "selfLink": "https://test.com/colors/000000"
        },
        "selfLink": "https://test.com/suggestions/colors/000000",
        "colorSearchLink": "https://test.com/colors/search/names?name=Test"
      },
      {
        "color": {
          "name": "Marsh",
          "hex": "#5c5337",
          "selfLink": "https://test.com/colors/5c5337"
        },
        "selfLink": "https://test.com/suggestions/colors/5c5337",
        "colorSearchLink": "https://test.com/colors/search/names?name=Marsh"
      },
      {
        "color": {
          "name": "Happy",
          "hex": "#f8d664",
          "selfLink": "https://test.com/colors/f8d664"
        },
        "selfLink": "https://test.com/suggestions/colors/f8d664",
        "colorSearchLink": "https://test.com/colors/search/names?name=Happy"
      }
    ]
  }
};

void main() {
  late ColorSuggestionsSearchApiService service;

  group("Given a $ColorSuggestionsSearchApiService with a null apiIndex", () {
    setUp(() {
      service = const ColorSuggestionsSearchApiService(
        client: HttpClientSuccessfulStub(responseBody: ""),
        pageRequestBuilder: UriPageRequestBuilder(),
        apiIndex: null,
        parser: ApiResponseParser(),
      );
    });

    group("when baseUri is called", () {
      test("then null is retrieved", () {
        expect(service.baseUri, isNull);
      });
    });

    group("when fetchContainingSearch is called", () {
      test("then null is retrieved", () async {
        final uri = await service.fetchContainingSearch(
          "",
          pageInfo: testPageInfo,
        );
        expect(uri, isNull);
      });
    });
  });

  group("Given a $ColorSuggestionsApiService with a valid apiIndex", () {
    setUp(() {
      final apiIndex = ApiIndex.fromJsonEntries(testIndex);
      final responseBody = jsonEncode(testColorSuggestionsApiResponse);
      service = ColorSuggestionsSearchApiService(
        client: HttpClientSuccessfulStub(responseBody: responseBody),
        pageRequestBuilder: const UriPageRequestBuilder(),
        apiIndex: apiIndex,
        parser: const ApiResponseParser(),
      );
    });

    group("when baseUri is called", () {
      test("then the request uri is properly built", () {
        expect(
          service.baseUri.toString(),
          contains("https://test.com/suggestions/colors/search/names"),
        );
      });
    });

    group("when parseItemFromJson is called", () {
      test("then the named color is correctly parsed", () {
        const testNamedColorJson = {
          "color": {"name": "Test", "hex": "#000000"},
        };
        final namedColor = service.parseItemFromJson(testNamedColorJson);
        expect(
          namedColor,
          const NamedColor(name: "Test", hex: "#000000"),
        );
      });
    });

    group("when fetchContainingSearch is called", () {
      test("then the list page with the named color is retrieved", () async {
        final listPage = await service.fetchContainingSearch(
          "test",
          pageInfo: testPageInfo,
        );
        if (listPage == null) {
          fail("Expected non-null $ListPage");
        }
        expect(listPage.pageInfo, testPageInfo);
        expect(
          listPage.items.first,
          const NamedColor(name: "Test Color", hex: "#000000"),
        );
      });
    });
  });

  group("Given a $ColorSuggestionsSearchApiService with a failing client", () {
    setUp(() {
      service = const ColorSuggestionsSearchApiService(
        client: HttpClientFailingStub(),
        pageRequestBuilder: UriPageRequestBuilder(),
        apiIndex: null,
        parser: ApiResponseParser(),
      );
    });

    group("when fetchRandom is called", () {
      test("then null is retrieved", () async {
        final uri = await service.fetchContainingSearch(
          "test",
          pageInfo: testPageInfo,
        );
        expect(uri, isNull);
      });
    });
  });
}
