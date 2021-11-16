import 'dart:convert';

import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/suggestions/palette_suggestions_api_service.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../network_client/test_helpers/http_client_stubs.dart';
import '../../test_helpers/test_api_index_response.dart';

const testPageInfo = PageInfo(startIndex: 1, size: 3, pageIndex: 1);

const testPaletteSuggestionsApiResponse = {
  "apiVersion": "0.3.0",
  "method": "GET",
  "data": {
    "kind": "palette_suggestion",
    "currentItemCount": 3,
    "itemsPerPage": 3,
    "startIndex": 1,
    "totalItems": 3,
    "pageIndex": 1,
    "totalPages": 1,
    "selfLink": "https://test.com/suggestions/palettes/random?size=3",
    "items": [
      {
        "palette": {
          "id": "619396e040c7f0261f5f4010",
          "name": "Beautiful",
          "hexes": [
            {
              "hex": "#e5c1c1",
              "colorLink":
                  "https://test.com/colors/search/hexes/closest?hex=e5c1c1"
            },
            {
              "hex": "#cec8c6",
              "colorLink":
                  "https://test.com/colors/search/hexes/closest?hex=cec8c6"
            }
          ],
          "selfLink": "https://test.com/palettes/619396e040c7f0261f5f4010",
          "colorsSearchLink":
              "https://test.com/colors/search/hexes/closest?hex=e5c1c1&hex=cec8c6"
        },
        "selfLink":
            "https://test.com/suggestions/palettes/619396e040c7f0261f5f4010",
        "paletteSearchLink":
            "https://test.com/palettes/search/names?name=Beautiful"
      },
      {
        "palette": {
          "id": "619396e040c7f0261f5f4025",
          "name": "Cotton",
          "hexes": [
            {
              "hex": "#ff24f0",
              "colorLink":
                  "https://test.com/colors/search/hexes/closest?hex=ff24f0"
            },
            {
              "hex": "#ffffff",
              "colorLink":
                  "https://test.com/colors/search/hexes/closest?hex=ffffff"
            }
          ],
          "selfLink": "https://test.com/palettes/619396e040c7f0261f5f4025",
          "colorsSearchLink":
              "https://test.com/colors/search/hexes/closest?hex=ff24f0&hex=ffffff"
        },
        "selfLink":
            "https://test.com/suggestions/palettes/619396e040c7f0261f5f4025",
        "paletteSearchLink":
            "https://test.com/palettes/search/names?name=Cotton"
      },
      {
        "palette": {
          "id": "619396e040c7f0261f5f406b",
          "name": "Rainbow",
          "hexes": [
            {
              "hex": "#cc3333",
              "colorLink":
                  "https://test.com/colors/search/hexes/closest?hex=cc3333"
            },
            {
              "hex": "#9911aa",
              "colorLink":
                  "https://test.com/colors/search/hexes/closest?hex=9911aa"
            }
          ],
          "selfLink": "https://test.com/palettes/619396e040c7f0261f5f406b",
          "colorsSearchLink":
              "https://test.com/colors/search/hexes/closest?hex=cc3333&hex=9911aa"
        },
        "selfLink":
            "https://test.com/suggestions/palettes/619396e040c7f0261f5f406b",
        "paletteSearchLink":
            "https://test.com/palettes/search/names?name=Rainbow"
      }
    ]
  }
};

void main() {
  late PaletteSuggestionsApiService service;

  group("Given a $PaletteSuggestionsApiService with a null apiIndex", () {
    setUp(() {
      service = const PaletteSuggestionsApiService(
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

    group("when fetchRandom is called", () {
      test("then null is retrieved", () async {
        final uri = await service.fetchRandom(pageInfo: testPageInfo);
        expect(uri, isNull);
      });
    });
  });

  group("Given a $PaletteSuggestionsApiService with a valid apiIndex", () {
    setUp(() {
      final apiIndex = ApiIndex.fromJsonEntries(testIndex);
      final responseBody = jsonEncode(testPaletteSuggestionsApiResponse);
      service = PaletteSuggestionsApiService(
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
          contains("https://test.com/suggestions/palettes/random"),
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

    group("when fetchRandom is called", () {
      test("then the list page with the palette is retrieved", () async {
        final listPage = await service.fetchRandom(pageInfo: testPageInfo);
        if (listPage == null) {
          fail("Expected non-null $ListPage");
        }
        expect(listPage.pageInfo, testPageInfo);
        expect(listPage.items.first,
            const Palette(name: "Beautiful", hexCodes: ["#E5C1C1", "#CEC8C6"]));
      });
    });
  });

  group("Given a $PaletteSuggestionsApiService with a failing http client", () {
    setUp(() {
      service = const PaletteSuggestionsApiService(
        client: HttpClientFailingStub(),
        pageRequestBuilder: UriPageRequestBuilder(),
        apiIndex: null,
        parser: ApiResponseParser(),
      );
    });

    group("when fetchRandom is called", () {
      test("then null is retrieved", () async {
        final uri = await service.fetchRandom(pageInfo: testPageInfo);
        expect(uri, isNull);
      });
    });
  });
}
