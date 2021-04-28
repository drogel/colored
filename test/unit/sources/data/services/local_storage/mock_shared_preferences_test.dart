import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:colored/sources/data/services/local_storage/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart' as preferences;

const _kKey = "test";
const _kValue = true;

void main() {
  late LocalStorage localStorage;

  setUp(() async {
    localStorage = const SharedPreferences();
    preferences.SharedPreferences.setMockInitialValues({});
  });

  group("Given a LocalStorage based on system SharedPreferences", () {
    group("when getBool is called", () {
      test("then the expected initial mock value is retrieved", () async {
        preferences.SharedPreferences.setMockInitialValues({
          _kKey: _kValue,
        });

        final actual = await localStorage.getBool(key: _kKey);
        expect(actual, _kValue);
      });

      test("then null is retrieved if given a non-existent key", () async {
        preferences.SharedPreferences.setMockInitialValues({
          _kKey: _kValue,
        });

        final actual = await localStorage.getBool(key: "other");
        expect(actual, isNull);
      });
    });

    group("when storeBool is called", () {
      test("then the expected value is stored", () async {
        await expectLater(await localStorage.getBool(key: _kKey), isNull);
        await localStorage.storeBool(key: _kKey, value: _kValue);
        await expectLater(await localStorage.getBool(key: _kKey), _kValue);
      });
    });
  });
}
