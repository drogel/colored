import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart' as preferences;

class SharedPreferences implements LocalStorage {
  const SharedPreferences();

  @override
  Future<bool> storeBool({@required String key, @required bool value}) async {
    final instance = await preferences.SharedPreferences.getInstance();
    final didSet = await instance.setBool(key, value);
    return didSet;
  }

  @override
  Future<bool> getBool({@required String key}) async {
    final instance = await preferences.SharedPreferences.getInstance();
    final value = await instance.get(key);
    return value is bool ? value : null;
  }
}
