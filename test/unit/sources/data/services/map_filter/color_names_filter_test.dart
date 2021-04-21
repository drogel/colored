import 'package:colored/sources/data/services/map_filter/color_names_filter.dart';
import 'package:flutter_test/flutter_test.dart';

const _kTestMap = {
  "TestKey": "TestValue",
  "OtherKey": "OtherValue",
};

void main() {
  ColorNamesFilter? filter;

  setUp(() {
    filter = const ColorNamesFilter();
  });

  tearDown(() {
    filter = null;
  });

  group("Given a ColorNamesFilter", () {
    group("when filter is called", () {
      test("then map entries can be found by their key", () async {
        final actual = filter!.filter("TestKey", _kTestMap);
        final expected = {"TestKey": "TestValue"};
        expect(actual, expected);
      });

      test("then map entries can be found by their value", () async {
        final actual = filter!.filter("TestValue", _kTestMap);
        final expected = {"TestKey": "TestValue"};
        expect(actual, expected);
      });

      test("then an empty map is returned if search missed", () async {
        final actual = filter!.filter("NotFound", _kTestMap);
        expect(actual, {});
      });
    });
  });
}
