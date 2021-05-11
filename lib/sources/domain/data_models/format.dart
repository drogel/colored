import 'package:collection/collection.dart' show IterableExtension;

enum Format {
  hex,
  rgb,
  hsl,
  hsv,
}

Map<Format, String> _values = {
  Format.hex: "Hex",
  Format.rgb: "RGB",
  Format.hsl: "HSL",
  Format.hsv: "HSV",
};

extension FormatValue on Format {
  String get rawValue {
    final value = _values[this];
    if (value == null) {
      throw ArgumentError("No rawValue defined for $this");
    }
    return value;
  }

  static Format format(String rawValue) {
    final value = _values.keys.firstWhereOrNull(
      (format) => format.rawValue == rawValue,
    );
    if (value == null) {
      throw ArgumentError("No format defined for $rawValue");
    }
    return value;
  }
}
