import 'package:colored/sources/presentation/widgets/pickers/color_thumb.dart';
import 'package:colored/sources/presentation/widgets/pickers/hue_picker/surface_slider.dart';
import 'package:flutter/material.dart';

class HuePicker extends StatefulWidget {
  const HuePicker({
    @required this.color,
    @required this.hueCanvas,
    @required this.onValueChange,
    this.indicatorDarkOuterColor,
    this.indicatorLightOuterColor,
    Key key,
  })  : assert(color != null),
        assert(hueCanvas != null),
        super(key: key);

  final Color color;
  final Color indicatorDarkOuterColor;
  final Color indicatorLightOuterColor;
  final Widget hueCanvas;
  final void Function(double, double) onValueChange;

  @override
  _HuePickerState createState() => _HuePickerState();
}

class _HuePickerState extends State<HuePicker> {
  @override
  Widget build(BuildContext context) => SurfaceSlider(
        onChanged: (_, __) {},
        thumb: ColorThumb(color: widget.color),
        child: widget.hueCanvas,
      );
}
