import 'package:colored/sources/domain/data_models/picker_style.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a PickerStyle", () {
    group("when rawValue called", () {
      test("then expected raw String value is retrieved", () {
        expect(PickerStyle.rgb.rawValue, "RGB");
        expect(PickerStyle.hsl.rawValue, "HSL");
        expect(PickerStyle.hsv.rawValue, "HSV");
      });
    });
  });
}