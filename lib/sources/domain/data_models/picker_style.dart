enum PickerStyle {
  rgb,
  hsl,
  hsv,
}

extension PickerStyleValue on PickerStyle {
  String get rawValue {
    switch (this) {
      case PickerStyle.rgb:
        return "RGB";
      case PickerStyle.hsl:
        return "HSL";
      case PickerStyle.hsv:
        return "HSV";
    }
  }
}
