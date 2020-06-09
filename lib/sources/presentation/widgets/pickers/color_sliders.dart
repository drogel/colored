import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/app/styling/colors/color_constants.dart'
    as colors;
import 'package:expandable_slider/expandable_slider.dart';
import 'package:flutter/material.dart';

class ColorSliders extends StatefulWidget {
  const ColorSliders({
    @required this.firstValue,
    @required this.secondValue,
    @required this.thirdValue,
    @required this.onChanged,
    @required this.onChangeEnd,
    @required this.step,
    this.controller,
    Key key,
  })  : assert(onChanged != null),
        super(key: key);

  final void Function(ColorSelection) onChanged;
  final void Function(ColorSelection) onChangeEnd;
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double step;
  final ExpandableSliderController controller;

  @override
  _ColorSlidersState createState() => _ColorSlidersState();
}

class _ColorSlidersState extends State<ColorSliders> {
  double _firstValue;
  double _secondValue;
  double _thirdValue;

  @override
  void initState() {
    _firstValue = widget.firstValue;
    _secondValue = widget.secondValue;
    _thirdValue = widget.thirdValue;
    super.initState();
  }

  @override
  void didUpdateWidget(ColorSliders oldWidget) {
    if (oldWidget.firstValue != widget.firstValue) {
      _firstValue = widget.firstValue;
    }
    if (oldWidget.secondValue != widget.secondValue) {
      _secondValue = widget.secondValue;
    }
    if (oldWidget.thirdValue != widget.thirdValue) {
      _thirdValue = widget.thirdValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final opacity = OpacityData.of(context).opacityScheme;
    return LayoutBuilder(
      builder: (_, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ExpandableSlider(
            value: _firstValue,
            activeColor: colors.red,
            inactiveColor: colors.red.withOpacity(opacity.fadedColor),
            estimatedValueStep: widget.step,
            onChangeEnd: _onChangeEnd,
            onChanged: (value) {
              _firstValue = value;
              widget.onChanged(_getSelection());
            },
            controller: widget.controller,
          ),
          ExpandableSlider(
            value: _secondValue,
            activeColor: colors.green,
            inactiveColor: colors.green.withOpacity(opacity.fadedColor),
            estimatedValueStep: widget.step,
            onChangeEnd: _onChangeEnd,
            onChanged: (value) {
              _secondValue = value;
              widget.onChanged(_getSelection());
            },
            controller: widget.controller,
          ),
          ExpandableSlider(
            value: _thirdValue,
            activeColor: colors.blue,
            inactiveColor: colors.blue.withOpacity(opacity.fadedColor),
            estimatedValueStep: widget.step,
            onChangeEnd: _onChangeEnd,
            onChanged: (value) {
              _thirdValue = value;
              widget.onChanged(_getSelection());
            },
            controller: widget.controller,
          ),
        ],
      ),
    );
  }

  ColorSelection _getSelection() => ColorSelection(
        r: _firstValue,
        g: _secondValue,
        b: _thirdValue,
      );

  void _onChangeEnd(double value) {
    if (widget.onChangeEnd != null) {
      widget.onChangeEnd(_getSelection());
    }
  }
}
