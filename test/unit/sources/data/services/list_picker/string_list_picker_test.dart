import 'package:colored/sources/data/services/int_generator/int_generator.dart';
import 'package:colored/sources/data/services/list_picker/list_picker.dart';
import 'package:colored/sources/data/services/list_picker/string_list_picker.dart';
import 'package:flutter_test/flutter_test.dart';

class IntGeneratorStub implements IntGenerator {
  const IntGeneratorStub();

  static const List<int> stubbedInts = [1, 2];

  @override
  List<int> generate({int? max, int? length}) => stubbedInts;
}

void main() {
  late ListPicker<String> listPicker;
  late IntGenerator intGenerator;

  setUp(() {
    intGenerator = const IntGeneratorStub();
    listPicker = StringListPicker(intGenerator: intGenerator);
  });

  group("Given a StringListPicker", () {
    group("when pick is called", () {
      test("then selected indexes are returned, based on generated ints", () {
        const inputStrings = ["test1", "test2", "test3", "test4"];
        final actual = listPicker.pick(from: inputStrings, count: 2);
        expect(actual, ["test2", "test3"]);
      });
    });
  });
}
