enum PickerStyle {
  rgb,
  hsl,
  hsv,
}

Map<PickerStyle, String> _values = {
  PickerStyle.rgb: "RGB",
  PickerStyle.hsl: "HSL",
  PickerStyle.hsv: "HSV",
};

extension PickerStyleValue on PickerStyle {
  String? get rawValue => _values[this];
}