import 'dart:ui';

extension MultiLerp on Color {
  static Color multiLerp(List<Color> colors, double t) {
    final clampedT = t.clamp(0, colors.length - 1);
    final firstColor = colors[clampedT.floor()];
    final secondColor = colors[clampedT.floor() + 1];
    final newT = clampedT - clampedT.floor();
    return Color.lerp(firstColor, secondColor, newT);
  }
}
