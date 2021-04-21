import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/app/styling/colors/color_constants.dart'
    as colors;
import 'package:expandable_slider/expandable_slider.dart';
import 'package:flutter/material.dart';

const _kDefaultStep = 1 / decimal8Bit;

class RgbPicker extends StatefulWidget {
  const RgbPicker({
    required this.selection,
    required this.onChanged,
    required this.onChangeEnd,
    this.step = _kDefaultStep,
    this.shouldShrink = false,
    Key? key,
  })  : assert(onChanged != null),
        super(key: key);

  final void Function(ColorSelection) onChanged;
  final void Function(ColorSelection) onChangeEnd;
  final ColorSelection selection;
  final double step;
  final bool shouldShrink;

  @override
  _RgbPickerState createState() => _RgbPickerState();
}

class _RgbPickerState extends State<RgbPicker> {
  ExpandableSliderController? _controller;
  late double _firstValue;
  late double _secondValue;
  late double _thirdValue;

  @override
  void initState() {
    _controller = ExpandableSliderController();
    _firstValue = widget.selection.r;
    _secondValue = widget.selection.g;
    _thirdValue = widget.selection.b;
    super.initState();
  }

  @override
  void didUpdateWidget(RgbPicker oldWidget) {
    if (oldWidget.selection.r != widget.selection.r) {
      _firstValue = widget.selection.r;
    }
    if (oldWidget.selection.g != widget.selection.g) {
      _secondValue = widget.selection.g;
    }
    if (oldWidget.selection.b != widget.selection.b) {
      _thirdValue = widget.selection.b;
    }
    if (oldWidget.shouldShrink != widget.shouldShrink && widget.shouldShrink) {
      _controller!.shrink();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final opacity = OpacityData.of(context)!.opacityScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ExpandableSlider(
          value: _firstValue,
          activeColor: colors.red,
          inactiveColor: colors.red!.withOpacity(opacity.fadedColor),
          estimatedValueStep: widget.step,
          onChangeEnd: _onChangeEnd,
          onChanged: (value) {
            _firstValue = value;
            widget.onChanged(_getSelection());
          },
          controller: _controller,
        ),
        ExpandableSlider(
          value: _secondValue,
          activeColor: colors.green,
          inactiveColor: colors.green!.withOpacity(opacity.fadedColor),
          estimatedValueStep: widget.step,
          onChangeEnd: _onChangeEnd,
          onChanged: (value) {
            _secondValue = value;
            widget.onChanged(_getSelection());
          },
          controller: _controller,
        ),
        ExpandableSlider(
          value: _thirdValue,
          activeColor: colors.blue,
          inactiveColor: colors.blue!.withOpacity(opacity.fadedColor),
          estimatedValueStep: widget.step,
          onChangeEnd: _onChangeEnd,
          onChanged: (value) {
            _thirdValue = value;
            widget.onChanged(_getSelection());
          },
          controller: _controller,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
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
