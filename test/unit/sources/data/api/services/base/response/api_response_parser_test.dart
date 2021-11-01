import 'dart:convert';

import 'package:colored/sources/data/api/models/responses/api_response.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/network_client/http_response.dart';
import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../../../test_helpers/test_api_index_response.dart';

void main() {
  late ApiResponseParser parser;

  group("Given a $ApiResponseParser with a successful client response", () {
    setUp(() {
      parser = const ApiResponseParser();
    });

    group("when parsing an $ApiResponse", () {
      test("then a valid response is retrieved", () {
        final testApiResponse = jsonEncode(testApiIndexResponse);
        final httpResponse = http.Response(testApiResponse, 200);
        final response = HttpResponse(
          status: ResponseStatus.ok,
          httpResponse: httpResponse,
        );
        final apiResponse = parser.parse(response);
        expect(apiResponse, isNotNull);
      });
    });
  });

  group("Given a $ApiResponseParser with a failed client response", () {
    setUp(() {
      parser = const ApiResponseParser();
    });

    group("when parsing an $ApiResponse from a failed status code", () {
      test("then null is retrieved", () {
        final testApiResponse = jsonEncode(testApiIndexResponse);
        final httpResponse = http.Response(testApiResponse, 400);
        final response = HttpResponse(
          status: ResponseStatus.failed,
          httpResponse: httpResponse,
        );
        final apiResponse = parser.parse(response);
        expect(apiResponse, isNull);
      });
    });

    group("when parsing an $ApiResponse from a null httpResponse", () {
      test("then null is retrieved", () {
        const response = HttpResponse(
          status: ResponseStatus.ok,
          httpResponse: null,
        );
        final apiResponse = parser.parse(response);
        expect(apiResponse, isNull);
      });
    });

    group("when parsing an $ApiResponse from a non-$ApiResponse map", () {
      test("then null is retrieved", () {
        final testApiResponse = jsonEncode(failingApiIndexResponse);
        final httpResponse = http.Response(testApiResponse, 200);
        final response = HttpResponse(
          status: ResponseStatus.ok,
          httpResponse: httpResponse,
        );
        final apiResponse = parser.parse(response);
        expect(apiResponse, isNull);
      });
    });
  });
}
