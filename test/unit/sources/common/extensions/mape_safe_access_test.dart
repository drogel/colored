import 'package:colored/sources/common/extensions/map_safe_access.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testMap = {
    "testString": "testValue",
    "testList": ["testValue"],
  };

  group("Given a JSON-like map", () {
    group("when retrieving values", () {
      test("then a generic value can be retrieved", () {
        final value = testMap.valueFor<String>("testString");
        if (value == null) {
          fail("Expected value to be not null");
        }
        expect(value, "testValue");
      });

      test("then a generic value returns null if types don't match", () {
        final value = testMap.valueFor<int>("testString");
        expect(value, isNull);
      });

      test("then a string value can be retrieved", () {
        final value = testMap.stringValueFor("testString");
        expect(value, "testValue");
      });

      test("then retrieved string is empty if not found", () {
        final value = testMap.stringValueFor("notFoundString");
        expect(value, "");
      });

      test("then a list value can be retrieved", () {
        final value = testMap.listValueFor<String>("testList");
        expect(value, ["testValue"]);
      });

      test("then retrieved list is empty if not found", () {
        final value = testMap.listValueFor<String>("testString");
        expect(value, []);
      });
    });
  });
}
