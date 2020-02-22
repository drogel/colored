import 'package:colored/sources/style/opacities.dart' as opacities;
import 'package:colored/sources/style/durations.dart' as durations;
import 'package:colored/sources/style/curves.dart' as curves;
import 'package:flutter/material.dart';

const _kValueChangeAnimationThreshold = 0.1;

class ColorSlider extends StatefulWidget {
  const ColorSlider({
    @required this.initialValue,
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

  final double initialValue;
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
      value: widget.initialValue,
      duration: widget.duration,
    );
    _animationController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Slider.adaptive(
        value: _animationController.value,
        onChanged: _updateValue,
        activeColor: widget.color,
        inactiveColor: widget.color.withOpacity(widget.inactiveOpacity),
      );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateValue(double newValue) {
    var currentValue = _animationController.value;
    if ((currentValue - newValue).abs() > _kValueChangeAnimationThreshold) {
      _animationController.animateTo(newValue, curve: widget.curve);
    } else {
      _animationController.value = newValue;
    }
    widget.onChanged(newValue);
  }
}
