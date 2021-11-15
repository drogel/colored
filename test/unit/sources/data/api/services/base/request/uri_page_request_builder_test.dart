import 'package:colored/sources/data/api/services/base/request/page_request_builder.dart';
import 'package:colored/sources/data/api/services/base/request/uri_page_request_builder.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PageRequestBuilder requestBuilder;

  const testPageInfo = PageInfo(pageIndex: 1, size: 1, startIndex: 1);

  group("Given $PageRequestBuilder", () {
    setUp(() {
      requestBuilder = const UriPageRequestBuilder();
    });

    group("when given a $Uri with $PageInfo without parameters", () {
      test("then the $PageInfo is appended to the request parameters", () {
        final testUri = Uri.parse("https://test.com");
        final actual = requestBuilder.addPageParameters(
          testUri,
          pageInfo: testPageInfo,
        );
        expect(actual.toString(), "https://test.com?size=1&page=1");
      });
    });

    group("when given a $Uri with $PageInfo with parameters", () {
      test("then the $PageInfo is appended to the request parameters", () {
        final testUri = Uri.parse("https://test.com?names=test");
        final actual = requestBuilder.addPageParameters(
          testUri,
          pageInfo: testPageInfo,
        );
        expect(actual.toString(), "https://test.com?size=1&page=1&names=test");
      });
    });

    group("when given a $Uri with $PageInfo with a list of parameters", () {
      test("then the $PageInfo is appended to the request parameters", () {
        final testUri = Uri.parse(
          "https://test.com?names=test&names=test2&names=test3",
        );
        final actual = requestBuilder.addPageParameters(
          testUri,
          pageInfo: testPageInfo,
        );
        expect(
          actual.toString(),
          "https://test.com?size=1&page=1&names=test&names=test2&names=test3",
        );
      });
    });
  });
}
