import 'package:colored/sources/presentation/widgets/color_pickers/base/color_thumb.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/base/surface_slider.dart';
import 'package:flutter/material.dart';

class SurfaceColorPicker extends StatelessWidget {
  const SurfaceColorPicker({
    @required this.color,
    @required this.value,
    @required this.track,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    Key key,
  })  : assert(color != null),
        assert(track != null),
        assert(value != null),
        super(key: key);

  final Color color;
  final Offset value;
  final Widget track;
  final void Function(double, double) onChanged;
  final void Function(double, double) onChangeStart;
  final void Function(double, double) onChangeEnd;

  @override
  Widget build(BuildContext context) => SurfaceSlider(
        value: value,
        onChanged: onChanged,
        onChangeEnd: onChangeEnd,
        onChangeStart: onChangeStart,
        thumbBuilder: (pressed) => ColorThumb(color: color, isPressed: pressed),
        child: track,
      );
}
