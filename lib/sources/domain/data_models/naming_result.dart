import 'package:vector_math/hash.dart';

class NamingResult {
  const NamingResult({
    this.name,
    this.hex,
    this.r,
    this.g,
    this.b,
    this.distance,
    this.luminance,
    this.requestedHex,
  });

  factory NamingResult.fromMap(Map<String, dynamic> map) => NamingResult(
        name: map["name"],
        hex: map["hex"],
        r: map[_rgb]["r"],
        g: map[_rgb]["g"],
        b: map[_rgb]["b"],
        distance: map["distance"],
        luminance: map["luminance"],
        requestedHex: map["requestedHex"],
      );

  static const _rgb = "rgb";

  final String name;
  final String hex;
  final int r;
  final int g;
  final int b;
  final int distance;
  final double luminance;
  final String requestedHex;

  @override
  bool operator ==(Object other) =>
      other is NamingResult && other.name == name && other.hex == hex;

  @override
  int get hashCode => hashObjects([name, hex]);
}
