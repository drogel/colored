import 'dart:async';

abstract class Memoizer<T> {
  Future<T> runOnce(FutureOr<T> Function() computation);
}
