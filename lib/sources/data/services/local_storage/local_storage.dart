import 'package:flutter/foundation.dart';

abstract class LocalStorage {
  Future<bool> storeBool({required String? key, required bool? value});

  Future<bool?> getBool({required String? key});
}
