import 'dart:convert';

import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/suggestions/palette_suggestions_search_api_service.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../network_client/test_helpers/http_client_stubs.dart';
import '../../test_helpers/test_api_index_response.dart';

const testPageInfo = PageInfo(startIndex: 1, size: 1, pageIndex: 1);

const testPaletteSuggestionsApiResponse = {
  "apiVersion": "0.3.0",
  "method": "GET",
  "data": {
    "kind": "palette_suggestion",
    "currentItemCount": 1,
    "itemsPerPage": 1,
    "startIndex": 1,
    "totalItems": 1,
    "pageIndex": 1,
    "totalPages": 1,
    "selfLink": "https://test.com/suggestions/palettes/search/names?name=bla",
    "items": [
      {
        "palette": {
          "id": "619396e040c7f0261f5f400f",
          "name": "Black",
          "hexes": [
            {
              "hex": "#4aec55",
              "colorLink":
                  "https://test.com/colors/search/hexes/closest?hex=4aec55"
            },
            {
              "hex": "#000000",
              "colorLink":
                  "https://test.com/colors/search/hexes/closest?hex=000000"
            }
          ],
          "selfLink": "https://test.com/palettes/619396e040c7f0261f5f400f",
          "colorsSearchLink":
              "https://test.com/colors/search/hexes/closest?hex=4aec55&hex=000000"
        },
        "selfLink":
            "https://test.com/suggestions/palettes/619396e040c7f0261f5f400f",
        "paletteSearchLink": "https://test.com/palettes/search/names?name=Black"
      }
    ]
  }
};

void main() {
  late PaletteSuggestionsSearchApiService service;

  group("Given a $PaletteSuggestionsSearchApiService with a null apiIndex", () {
    setUp(() {
      service = const PaletteSuggestionsSearchApiService(
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

  group("Given a $PaletteSuggestionsSearchApiService with valid apiIndex", () {
    setUp(() {
      final apiIndex = ApiIndex.fromJsonEntries(testIndex);
      final responseBody = jsonEncode(testPaletteSuggestionsApiResponse);
      service = PaletteSuggestionsSearchApiService(
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
          contains("https://test.com/suggestions/palettes/search/names"),
        );
      });
    });

    group("when parseItemFromJson is called", () {
      test("then the palette is correctly parsed", () {
        const testPaletteJson = {
          "palette": {
            "name": "Test",
            "hexes": [
              {"hex": "#000000"},
              {"hex": "#FFFFFF"},
            ]
          },
        };
        final palette = service.parseItemFromJson(testPaletteJson);
        expect(palette,
            const Palette(name: "Test", hexCodes: ["#000000", "#FFFFFF"]));
      });
    });

    group("when fetchContainingSearch is called", () {
      test("then the list page with the palette is retrieved", () async {
        final listPage = await service.fetchContainingSearch(
          "bla",
          pageInfo: testPageInfo,
        );
        if (listPage == null) {
          fail("Expected non-null $ListPage");
        }
        expect(listPage.pageInfo, testPageInfo);
        expect(listPage.items.first,
            const Palette(name: "Black", hexCodes: ["#4AEC55", "#000000"]));
      });
    });
  });

  group("Given a $PaletteSuggestionsSearchApiService with failing client", () {
    setUp(() {
      service = const PaletteSuggestionsSearchApiService(
        client: HttpClientFailingStub(),
        pageRequestBuilder: UriPageRequestBuilder(),
        apiIndex: null,
        parser: ApiResponseParser(),
      );
    });

    group("when fetchContainingSearch is called", () {
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
