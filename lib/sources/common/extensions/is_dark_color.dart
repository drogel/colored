import 'dart:ui';

extension IsDark on Color {
  bool isDark() {
    const redFactor = 0.299;
    const greenFactor = 0.587;
    const blueFactor = 0.114;
    final luminance = redFactor * red + greenFactor * green + blueFactor * blue;
    final darkness = 1 - luminance / 255;
    return darkness > 0.5;
  }
}
