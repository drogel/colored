import 'package:colored/sources/data/services/map_filter/palette_filter.dart';
import 'package:flutter_test/flutter_test.dart';

const _kTestMap = {
  "TestKey": ["Test1", "Test2"],
  "OtherKey": ["Other1", "Other2"],
};

void main() {
  late PaletteFilter filter;

  setUp(() {
    filter = const PaletteFilter();
  });

  group("Given a ColorNamesFilter", () {
    group("when filter is called", () {
      test("then map entries can be found by their key", () async {
        final actual = filter.filter("TestKey", _kTestMap);
        final expected = {
          "TestKey": ["Test1", "Test2"],
        };
        expect(actual, expected);
      });

      test("then an empty map is returned if search missed", () async {
        final actual = filter.filter("NotFound", _kTestMap);
        expect(actual, {});
      });
    });
  });
}
