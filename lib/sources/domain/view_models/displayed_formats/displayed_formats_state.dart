import 'package:collection/collection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:vector_math/hash.dart';

class DisplayedFormatsState {
  const DisplayedFormatsState(this.formats);

  final List<Format> formats;

  @override
  bool operator ==(Object other) =>
      other is DisplayedFormatsState &&
      const ListEquality().equals(formats, other.formats);

  @override
  int get hashCode => hashObjects([this, formats]);

  @override
  String toString() => "DisplayedFormatsState($formats)";
}
