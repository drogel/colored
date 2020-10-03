import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart' as preferences;
import 'package:colored/sources/data/services/local_storage/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

const _kKey = "test";
const _kValue = true;

void main() {
  LocalStorage localStorage;

  setUp(() async {
    localStorage = const SharedPreferences();
    preferences.SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    localStorage = null;
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

      test("then null is retrieved if given a non-existant key", () async {
        preferences.SharedPreferences.setMockInitialValues({
          _kKey: _kValue,
        });

        final actual = await localStorage.getBool(key: "other");
        expect(actual, isNull);
      });

      test("then null is retrieved if given a null key", () async {
        final actual = await localStorage.getBool(key: null);

        expect(actual, isNull);
      });
    });

    group("when storeBool is called", () {
      test("false is returned if key is null", () async {
        final actual = await localStorage.storeBool(key: null, value: _kValue);

        expect(actual, isFalse);
      });

      test("false is returned if value is null", () async {
        final actual = await localStorage.storeBool(key: _kKey, value: null);

        expect(actual, isFalse);
      });

      test("then the expected value is stored", () async {
        await expectLater(await localStorage.getBool(key: _kKey), isNull);

        await localStorage.storeBool(key: _kKey, value: _kValue);

        await expectLater(await localStorage.getBool(key: _kKey), _kValue);
      });
    });
  });
}
