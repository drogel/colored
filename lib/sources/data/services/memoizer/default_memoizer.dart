import 'dart:async';

import 'package:async/async.dart';
import 'package:colored/sources/data/services/memoizer/memoizer.dart';

class DefaultMemoizer<T> extends Memoizer<T> {
  DefaultMemoizer() : _memoizer = AsyncMemoizer<T>();

  final AsyncMemoizer<T> _memoizer;

  @override
  Future<T> runOnce(FutureOr<T> Function() computation) =>
      _memoizer.runOnce(computation);
}
