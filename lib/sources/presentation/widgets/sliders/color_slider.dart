import 'package:colored/sources/style/colors.dart' as colors;
import 'package:flutter/material.dart';

class ColorSlider extends StatefulWidget {
  const ColorSlider({
    @required this.initialValue,
    @required this.color,
    @required this.onChanged,
    this.inactiveOpacity = colors.fadedOpacity,
    Key key,
  }) : super(key: key);

  final double initialValue;
  final Color color;
  final double inactiveOpacity;
  final void Function(double) onChanged;

  @override
  _ColorSliderState createState() => _ColorSliderState();
}

class _ColorSliderState extends State<ColorSlider> {
  double _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Slider.adaptive(
        value: _value,
        onChanged: _updateValue,
        activeColor: widget.color,
        inactiveColor: widget.color.withOpacity(widget.inactiveOpacity),
      );

  void _updateValue(double value) {
    setState(() => _value = value);
    widget.onChanged(value);
  }
}
