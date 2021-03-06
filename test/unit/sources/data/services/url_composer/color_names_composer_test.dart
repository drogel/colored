import 'package:colored/sources/data/services/url_composer/meodai_url_composer.dart';
import 'package:colored/sources/data/services/url_composer/url_composer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const _kTestBaseUrl = "test.com";
  const _kTestPath = "path";
  late UrlComposer composer;

  setUp(() {
    composer = const MeodaiUrlComposer();
  });

  group("Given a ColorNamesComposer", () {
    group("when compose is called", () {
      test("then the base url is returned if no path is given", () {
        final actual = composer.compose(_kTestBaseUrl);
        expect(actual, _kTestBaseUrl);
      });

      test("then the base url is returned if null path is given", () {
        final actual = composer.compose(_kTestBaseUrl, path: null);
        expect(actual, _kTestBaseUrl);
      });

      test("then the path is appended as a URL path", () {
        final actual = composer.compose(_kTestBaseUrl, path: _kTestPath);
        expect(actual, "$_kTestBaseUrl/$_kTestPath");
      });

      test("then the path is appended as a URL removing # symbols", () {
        final actual = composer.compose(_kTestBaseUrl, path: "#$_kTestPath");
        expect(actual, "$_kTestBaseUrl/$_kTestPath");
      });

      test("then path is added as comma-separated list on several #", () {
        final concatenatedPath = "#$_kTestPath" * 3;
        final actual = composer.compose(_kTestBaseUrl, path: concatenatedPath);
        expect(actual, "$_kTestBaseUrl/$_kTestPath,$_kTestPath,$_kTestPath");
      });
    });
  });
}
