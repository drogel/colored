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
  String? get rawValue => _values[this];
}

Format? formatValue(String rawValue) => _values.keys.firstWhereOrNull(
      (key) => _values[key] == rawValue,
    );
