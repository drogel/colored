import 'package:colored/sources/data/services/local_storage/local_storage.dart';

class MockLocalStorage implements LocalStorage {
  const MockLocalStorage();

  @override
  Future<bool?> getBool({required String key}) async => false;

  @override
  Future<bool> storeBool({required String key, required bool value}) async =>
      true;
}
