import 'package:colored/sources/common/extensions/uri_copy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Uri uri;

  group("Given a $Uri", () {
    setUp(() {
      uri = Uri(
        scheme: "testscheme",
        userInfo: "testUserInfo",
        host: "testhost",
        port: 0,
        path: "testPath",
        queryParameters: {"testQueryParameters": "testQueryParameters"},
        fragment: "testFragment",
      );
    });

    group("when copy is called", () {
      test("then a copy with the modified scheme is retrieved", () {
        final actual = uri.copy(scheme: "scheme");
        expect(actual.scheme, "scheme");
        expect(actual.userInfo, "testUserInfo");
        expect(actual.host, "testhost");
        expect(actual.port, 0);
        expect(actual.fragment, "testFragment");
      });

      test("then a copy with the modified userInfo is retrieved", () {
        final actual = uri.copy(userInfo: "userInfo");
        expect(actual.scheme, "testscheme");
        expect(actual.userInfo, "userInfo");
        expect(actual.host, "testhost");
        expect(actual.port, 0);
        expect(actual.pathSegments, ["testPath"]);
        expect(
          actual.queryParameters,
          {"testQueryParameters": "testQueryParameters"},
        );
        expect(actual.fragment, "testFragment");
      });

      test("then a copy with the modified host is retrieved", () {
        final actual = uri.copy(host: "host");
        expect(actual.scheme, "testscheme");
        expect(actual.userInfo, "testUserInfo");
        expect(actual.host, "host");
        expect(actual.port, 0);
        expect(actual.pathSegments, ["testPath"]);
        expect(
          actual.queryParameters,
          {"testQueryParameters": "testQueryParameters"},
        );
        expect(actual.fragment, "testFragment");
      });

      test("then a copy with the modified port is retrieved", () {
        final actual = uri.copy(port: 1);
        expect(actual.scheme, "testscheme");
        expect(actual.userInfo, "testUserInfo");
        expect(actual.host, "testhost");
        expect(actual.port, 1);
        expect(actual.pathSegments, ["testPath"]);
        expect(
          actual.queryParameters,
          {"testQueryParameters": "testQueryParameters"},
        );
        expect(actual.fragment, "testFragment");
      });

      test("then a copy with the modified path is retrieved", () {
        final actual = uri.copy(path: "path");
        expect(actual.scheme, "testscheme");
        expect(actual.userInfo, "testUserInfo");
        expect(actual.host, "testhost");
        expect(actual.port, 0);
        expect(actual.path, "/path");
        expect(
          actual.queryParameters,
          {"testQueryParameters": "testQueryParameters"},
        );
        expect(actual.fragment, "testFragment");
      });

      test("then a copy with the modified queryParameters is retrieved", () {
        final actual = uri.copy(
          queryParameters: {"queryParameters": "queryParameters"},
        );
        expect(actual.scheme, "testscheme");
        expect(actual.userInfo, "testUserInfo");
        expect(actual.host, "testhost");
        expect(actual.port, 0);
        expect(actual.path, "/testPath");
        expect(
          actual.queryParameters,
          {"queryParameters": "queryParameters"},
        );
        expect(actual.fragment, "testFragment");
      });

      test("then a copy with the modified fragment is retrieved", () {
        final actual = uri.copy(fragment: "fragment");
        expect(actual.scheme, "testscheme");
        expect(actual.userInfo, "testUserInfo");
        expect(actual.host, "testhost");
        expect(actual.port, 0);
        expect(actual.path, "/testPath");
        expect(
          actual.queryParameters,
          {"testQueryParameters": "testQueryParameters"},
        );
        expect(actual.fragment, "fragment");
      });
    });
  });
}
