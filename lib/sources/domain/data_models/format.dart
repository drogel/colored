enum Format {
  hex,
  rgb,
}

Map<Format, String> _values = {
  Format.hex: "Hex",
  Format.rgb: "RGB",
};

extension ColorFormatValue on Format {
  String get rawValue => _values[this];
}

Format formatValue(String rawValue) => _values.keys.firstWhere(
      (key) => _values[key] == rawValue,
      orElse: () => null,
    );
