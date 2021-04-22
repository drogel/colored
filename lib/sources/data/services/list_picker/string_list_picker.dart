import 'package:colored/sources/data/services/int_generator/int_generator.dart';
import 'package:colored/sources/data/services/list_picker/list_picker.dart';

class StringListPicker implements ListPicker<String> {
  const StringListPicker({required IntGenerator intGenerator})
      : _generator = intGenerator;

  final IntGenerator _generator;

  @override
  List<String> pick({required List<String> from, required int count}) {
    final chosenIndexes = _generator.generate(max: from.length, length: count);
    final selectedKeys = chosenIndexes.map((index) => from[index]).toList();
    return selectedKeys;
  }
}
