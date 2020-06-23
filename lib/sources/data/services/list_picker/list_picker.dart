import 'package:flutter/foundation.dart';

abstract class ListPicker<T> {
  List<T> pick({@required List<T> from, @required int count});
}