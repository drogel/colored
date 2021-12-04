import 'package:collection/collection.dart' show IterableExtension;

enum Format {
  hex,
  rgb,
  hsl,
  hsv,
}

const _hexString = "Hex";
const _rgbString = "RGB";
const _hslString = "HSL";
const _hsvString = "HSV";

Map<Format, String> _values = {
  Format.hex: _hexString,
  Format.rgb: _rgbString,
  Format.hsl: _hslString,
  Format.hsv: _hsvString,
};

extension FormatValue on Format {
  String get rawValue {
    switch (this) {
      case Format.hex:
        return _hexString;
      case Format.rgb:
        return _rgbString;
      case Format.hsl:
        return _hslString;
      case Format.hsv:
        return _hsvString;
    }
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
