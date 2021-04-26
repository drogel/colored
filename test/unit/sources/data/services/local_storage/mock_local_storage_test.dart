import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:colored/sources/data/services/local_storage/mock_local_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = const MockLocalStorage();
  });

  group("Given a MockLocalStorage", () {
    group("when getBool is called", () {
      test("then false is retrieved", () async {
        final actual = await mockLocalStorage.getBool(key: "test");
        expect(actual, isFalse);
      });
    });

    group("when storeBool is called", () {
      test("then true is retrieved", () async {
        final actual = await mockLocalStorage.storeBool(key: "", value: true);
        expect(actual, isTrue);
      });
    });
  });
}
