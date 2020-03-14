enum ColorFormat {
  hex,
  rgb,
}

extension ColorFormatValue on ColorFormat {
  static String _value(val) {
    switch (val) {
      case ColorFormat.hex:
        return "Hex";
      case ColorFormat.rgb:
        return "RGB";
    }
    return "";
  }

  String get value => _value(this);
}
