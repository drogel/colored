import 'package:colored/sources/styling/opacities.dart' as opacities;
import 'package:colored/sources/styling/durations.dart' as durations;
import 'package:colored/sources/styling/curves.dart' as curves;
import 'package:flutter/material.dart';

class ColorSlider extends StatefulWidget {
  const ColorSlider({
    @required this.value,
    @required this.color,
    @required this.onChanged,
    this.duration = durations.mediumPresenting,
    this.curve = curves.primary,
    this.inactiveOpacity = opacities.fadedColor,
    Key key,
  })  : assert(onChanged != null),
        assert(duration != null),
        assert(inactiveOpacity != null),
        super(key: key);

  final double value;
  final Color color;
  final double inactiveOpacity;
  final void Function(double) onChanged;
  final Duration duration;
  final Curve curve;

  @override
  _ColorSliderState createState() => _ColorSliderState();
}

class _ColorSliderState extends State<ColorSlider>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      value: widget.value,
      duration: widget.duration,
    );
    _animationController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void didUpdateWidget(ColorSlider oldWidget) {
    if (oldWidget.value != widget.value) {
      _animationController.animateTo(widget.value);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => Slider.adaptive(
        value: _animationController.value,
        onChanged: widget.onChanged,
        activeColor: widget.color,
        inactiveColor: widget.color.withOpacity(widget.inactiveOpacity),
      );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
