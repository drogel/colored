import 'dart:convert';

import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/index/api_index/api_index_fetcher.dart';
import 'package:colored/sources/data/api/services/index/api_index/api_index_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../network_client/test_helpers/http_client_stubs.dart';

void main() {
  late ApiIndexService service;

  const testApiIndexResponse = {
    "apiVersion": "0.2.1",
    "method": "GET",
    "data": {
      "kind": "index_entry",
      "currentItemCount": 3,
      "itemsPerPage": 10,
      "startIndex": 1,
      "totalItems": 3,
      "pageIndex": 1,
      "totalPages": 1,
      "selfLink": "https://test.com/",
      "items": [
        {
          "title": "colors",
          "endpoint": "https://test.com/colors/{hex}",
          "entries": [
            {
              "title": "colors_search",
              "entries": [
                {
                  "title": "colors_search_hexes",
                  "endpoint": "https://test.com/colors/search/hexes?hex={hex}",
                  "entries": [
                    {
                      "title": "colors_search_closest",
                      "endpoint":
                          "https://test.com/colors/search/hexes/closest?hex={hex}"
                    }
                  ]
                },
                {
                  "title": "colors_search_names",
                  "endpoint": "https://test.com/colors/search/names?name={name}"
                }
              ]
            }
          ]
        },
        {
          "title": "palettes",
          "endpoint": "https://test.com/palettes/{id}",
          "entries": [
            {
              "title": "palettes_search",
              "entries": [
                {
                  "title": "palettes_search_names",
                  "endpoint":
                      "https://test.com/palettes/search/names?name={name}"
                }
              ]
            }
          ]
        },
        {
          "title": "suggestions",
          "entries": [
            {
              "title": "colors_suggestions",
              "endpoint": "https://test.com/suggestions/colors/{hex}",
              "entries": [
                {
                  "title": "random_colors_suggestions",
                  "endpoint": "https://test.com/suggestions/colors/random"
                },
                {
                  "title": "colors_suggestions_search",
                  "entries": [
                    {
                      "title": "colors_suggestions_search_hexes",
                      "endpoint":
                          "https://test.com/suggestions/colors/search/hexes?hex={hex}",
                      "entries": [
                        {
                          "title": "colors_suggestions_search_closest",
                          "endpoint":
                              "https://test.com/suggestions/colors/search/hexes/closest?hex={hex}"
                        }
                      ]
                    },
                    {
                      "title": "colors_suggestions_search_names",
                      "endpoint":
                          "https://test.com/suggestions/colors/search/names?name={name}"
                    }
                  ]
                }
              ]
            },
            {
              "title": "palettes_suggestions",
              "endpoint": "https://test.com/suggestions/palettes/{id}",
              "entries": [
                {
                  "title": "random_palettes_suggestions",
                  "endpoint": "https://test.com/suggestions/palettes/random"
                },
                {
                  "title": "palettes_suggestions_search_names",
                  "endpoint":
                      "https://test.com/suggestions/palettes/search/names?name={name}"
                }
              ]
            }
          ]
        }
      ]
    }
  };

  const failingApiIndexResponse = {"testEntry": "testValue"};

  group("Given a $ApiIndexFetcher with a successful client", () {
    setUp(() {
      service = ApiIndexFetcher(
        client: HttpClientSuccessfulStub(
          responseBody: jsonEncode(testApiIndexResponse),
        ),
        apiIndexLink: "test",
      );
    });

    group("when fetching the api index", () {
      test("then a non-null, parsed $ApiIndex is retrieved", () async {
        final actual = await service.fetchApiIndex();
        if (actual == null) {
          fail("Expected $ApiIndex to be non null");
        }
        expect(actual, isNotNull);
        expect(actual.palettes, isNotNull);
        expect(actual.suggestions, isNotNull);
        expect(actual.colors, isNotNull);
      });
    });
  });

  group("Given a $ApiIndexFetcher with an incoherent client response", () {
    setUp(() {
      service = ApiIndexFetcher(
        client: HttpClientSuccessfulStub(
          responseBody: jsonEncode(failingApiIndexResponse),
        ),
        apiIndexLink: "test",
      );
    });

    group("when fetching the api index", () {
      test("then a null value is retrieved", () async {
        final actual = await service.fetchApiIndex();
        expect(actual, isNull);
      });
    });
  });

  group("Given a $ApiIndexFetcher with a failing client", () {
    setUp(() {
      service = ApiIndexFetcher(
        client: HttpClientFailingStub(),
        apiIndexLink: "test",
      );
    });

    group("when fetching the api index", () {
      test("then a null value is retrieved", () async {
        final actual = await service.fetchApiIndex();
        expect(actual, isNull);
      });
    });
  });
}
