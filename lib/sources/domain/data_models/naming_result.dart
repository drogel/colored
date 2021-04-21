import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter/foundation.dart';

class NamingResult extends NamedColor {
  const NamingResult({
    required String name,
    required String hex,
    this.r,
    this.g,
    this.b,
    this.distance,
    this.luminance,
    this.requestedHex,
  }) : super(name: name, hex: hex);

  factory NamingResult.fromMap(Map<String, dynamic> map) => NamingResult(
        name: map["name"],
        hex: map["hex"]?.toUpperCase(),
        r: map[_rgb]["r"],
        g: map[_rgb]["g"],
        b: map[_rgb]["b"],
        distance: map["distance"].toDouble(),
        luminance: map["luminance"].toDouble(),
        requestedHex: map["requestedHex"],
      );

  static const mappingKey = "colors";
  static const _rgb = "rgb";

  final int? r;
  final int? g;
  final int? b;
  final double? distance;
  final double? luminance;
  final String? requestedHex;
}
