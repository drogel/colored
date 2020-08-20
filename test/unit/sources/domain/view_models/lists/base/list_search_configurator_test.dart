import 'package:colored/sources/domain/view_models/lists/base/list_search_configurator.dart';
import 'package:colored/sources/domain/view_models/lists/base/search_configurator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SearchConfigurator configurator;

  setUp(() {
    configurator = const ListSearchConfigurator();
  });

  tearDown(() {
    configurator = null;
  });

  group("Given a ListSearchConfigurator", () {
    group("when cleanSearch is called", () {
      test("then left whitespaces are trimmed from searchString", () {
        const expected = "testSearch";
        final actual = configurator.cleanSearch("     $expected");
        expect(actual, expected);
      });

      test("all hash characters are erased from searchString", () {
        const expected = "testSearch";
        final actual = configurator.cleanSearch("#$expected#");
        expect(expected, actual);
      });
    });

    group("when minSearchLength is called", () {
      test("3 is retrieved as the minimum length for a valid search", () {
        expect(configurator.minSearchLength, 3);
      });
    });
  });
}
