import 'package:colored/sources/data/services/local_storage/local_storage.dart';

class MockLocalStorage implements LocalStorage {
  const MockLocalStorage();

  @override
  Future<bool> getBool({String key}) async => true;

  @override
  Future<bool> storeBool({String key, bool value}) async => true;
}
