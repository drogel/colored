import 'dart:convert';

import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/index/api_index/api_index_fetcher.dart';
import 'package:colored/sources/data/api/services/index/api_index/api_index_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../network_client/test_helpers/http_client_stubs.dart';
import '../../../test_helpers/test_api_index_response.dart';

void main() {
  late ApiIndexService service;

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
