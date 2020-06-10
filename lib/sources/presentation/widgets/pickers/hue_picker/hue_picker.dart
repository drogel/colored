import 'package:colored/sources/presentation/widgets/pickers/color_thumb.dart';
import 'package:colored/sources/presentation/widgets/pickers/hue_picker/hue_canvas.dart';
import 'package:colored/sources/presentation/widgets/pickers/hue_picker/surface_slider.dart';
import 'package:flutter/material.dart';

class HuePicker extends StatelessWidget {
  const HuePicker({
    @required this.color,
    @required this.hueCanvas,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    Key key,
  })  : assert(color != null),
        assert(hueCanvas != null),
        super(key: key);

  final Color color;
  final HueCanvas hueCanvas;
  final void Function(double, double) onChanged;
  final void Function(double, double) onChangeStart;
  final void Function(double, double) onChangeEnd;

  @override
  Widget build(BuildContext context) => SurfaceSlider(
        onChanged: onChanged,
        onChangeEnd: onChangeEnd,
        onChangeStart: onChangeStart,
        thumb: ColorThumb(color: color),
        child: hueCanvas,
      );
}
