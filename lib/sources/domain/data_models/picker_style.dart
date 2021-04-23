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
  String get rawValue {
    final value = _values[this];
    if (value == null) {
      throw ArgumentError("No rawValue defined for $this");
    }
    return value;
  }
}
