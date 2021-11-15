import 'dart:convert';

import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/names/base_api_names_service.dart';
import 'package:colored/sources/data/api/services/naming/color_naming_api_service.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../network_client/test_helpers/http_client_stubs.dart';
import '../../test_helpers/test_api_index_response.dart';

const testPageInfo = PageInfo(startIndex: 1, size: 1, pageIndex: 1);

const testNamingResponse = {
  "apiVersion": "0.3.0",
  "method": "GET",
  "data": {
    "kind": "color",
    "currentItemCount": 1,
    "itemsPerPage": 1,
    "startIndex": 1,
    "totalItems": 1,
    "pageIndex": 1,
    "totalPages": 1,
    "selfLink": "https://test.com/colors/search/hexes/closest?hex=000000",
    "items": [
      {
        "name": "Test Color",
        "hex": "#000000",
        "selfLink": "https://test.com/colors/000000"
      }
    ]
  }
};

void main() {
  late BaseApiNamesService<NamedColor> service;

  group("Given a $ColorNamingApiService with a null apiIndex", () {
    setUp(() {
      service = const ColorNamingApiService(
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

  group("Given a $ColorNamingApiService with a valid apiIndex", () {
    setUp(() {
      final apiIndex = ApiIndex.fromJsonEntries(testIndex);
      final responseBody = jsonEncode(testNamingResponse);
      service = ColorNamingApiService(
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
          contains("https://test.com/colors/search/hexes/closest"),
        );
      });
    });

    group("when parseItemFromJson is called", () {
      test("then the named color is correctly parsed", () {
        const testNamedColorJson = {"name": "Test", "hex": "#000000"};
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
          "#000000",
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

  group("Given a $ColorNamingApiService with a failing http client", () {
    setUp(() {
      service = const ColorNamingApiService(
        client: HttpClientFailingStub(),
        pageRequestBuilder: UriPageRequestBuilder(),
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
