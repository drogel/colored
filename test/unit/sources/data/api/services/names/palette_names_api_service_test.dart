import 'dart:convert';

import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/names/base_api_names_service.dart';
import 'package:colored/sources/data/api/services/names/color_names_api_service.dart';
import 'package:colored/sources/data/api/services/names/palette_names_api_service.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../network_client/test_helpers/http_client_stubs.dart';
import '../../test_helpers/test_api_index_response.dart';

const testPageInfo = PageInfo(startIndex: 1, size: 1, pageIndex: 1);

const testColorNamesApiResponse = {
  "apiVersion": "0.2.1",
  "method": "GET",
  "data": {
    "kind": "palette",
    "currentItemCount": 1,
    "itemsPerPage": 1,
    "startIndex": 1,
    "totalItems": 261,
    "pageIndex": 1,
    "totalPages": 261,
    "pagingLinkTemplate":
        "https://test.com/palettes/search/names?name=Test{&page,size}",
    "nextLink":
        "https://test.com/palettes/search/names?name=Test&size=1&page=2",
    "selfLink": "https://test.com/palettes/search/names?name=Test&size=1",
    "items": [
      {
        "name": "Test Palette",
        "hexes": ["#ffffff", "#000000"],
        "selfLink": "https://test.com/palettes/000000"
      }
    ]
  }
};

void main() {
  late BaseApiNamesService<Palette> service;

  group("Given a $PaletteNamesApiService with a null apiIndex", () {
    setUp(() {
      service = const PaletteNamesApiService(
        client: HttpClientSuccessfulStub(responseBody: ""),
        apiIndex: null,
        parser: ApiResponseParser(),
      );
    });

    group("when buildSearchUri is called", () {
      test("then null is retrieved", () {
        final uri = service.buildSearchUri("", pageInfo: testPageInfo);
        expect(uri, isNull);
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

  group("Given a $PaletteNamesApiService with a valid apiIndex", () {
    setUp(() {
      final apiIndex = ApiIndex.fromJsonEntries(testIndex);
      final responseBody = jsonEncode(testColorNamesApiResponse);
      service = PaletteNamesApiService(
        client: HttpClientSuccessfulStub(responseBody: responseBody),
        apiIndex: apiIndex,
        parser: const ApiResponseParser(),
      );
    });

    group("when buildSearchUri is called", () {
      test("then the request uri is properly built", () {
        const testSearch = "testSearch";
        final uri = service.buildSearchUri(testSearch, pageInfo: testPageInfo);
        expect(
          uri.toString(),
          "https://test.com/palettes/search/names?name=testSearch&size=1&page=1#",
        );
      });
    });

    group("when parseItemFromJson is called", () {
      test("then the palette is correctly parsed", () {
        final testPaletteJson = {
          "name": "Test",
          "hexes": ["#ffffff", "#000000"]
        };
        final palette = service.parseItemFromJson(testPaletteJson);
        expect(
          palette,
          const Palette(name: "Test", hexCodes: ["#FFFFFF", "#000000"]),
        );
      });
    });

    group("when fetchContainingSearch is called", () {
      test("then the list page with the named color is retrieved", () async {
        final listPage = await service.fetchContainingSearch(
          "Test",
          pageInfo: testPageInfo,
        );
        if (listPage == null) {
          fail("Expected non-null $ListPage");
        }
        expect(listPage.pageInfo, testPageInfo);
        expect(
          listPage.items.first,
          const Palette(name: "Test Palette", hexCodes: ["#FFFFFF", "#000000"]),
        );
      });
    });
  });

  group("Given a $ColorNamesApiService with a failing http client", () {
    setUp(() {
      service = const PaletteNamesApiService(
        client: HttpClientFailingStub(),
        apiIndex: null,
        parser: ApiResponseParser(),
      );
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
}
