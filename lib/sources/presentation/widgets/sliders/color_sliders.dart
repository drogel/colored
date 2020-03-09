import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/styling/colors.dart' as colors;
import 'package:colored/sources/styling/opacities.dart' as opacities;
import 'package:expandable_slider/expandable_slider.dart';
import 'package:flutter/material.dart';

class ColorSliders extends StatefulWidget {
  const ColorSliders({
    @required this.firstValue,
    @required this.secondValue,
    @required this.thirdValue,
    @required this.onChanged,
    @required this.step,
    Key key,
  })  : assert(onChanged != null),
        super(key: key);

  final void Function(ColorSelection) onChanged;
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double step;

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
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ExpandableSlider(
              value: _firstValue,
              activeColor: colors.red,
              inactiveColor: colors.red.withOpacity(opacities.fadedColor),
              estimatedValueStep: widget.step,
              onChanged: (value) {
                _firstValue = value;
                _notifyChange();
              },
            ),
            ExpandableSlider(
              value: _secondValue,
              activeColor: colors.green,
              inactiveColor: colors.green.withOpacity(opacities.fadedColor),
              estimatedValueStep: widget.step,
              onChanged: (value) {
                _secondValue = value;
                _notifyChange();
              },
            ),
            ExpandableSlider(
              value: _thirdValue,
              activeColor: colors.blue,
              inactiveColor: colors.blue.withOpacity(opacities.fadedColor),
              estimatedValueStep: widget.step,
              onChanged: (value) {
                _thirdValue = value;
                _notifyChange();
              },
            ),
          ],
        ),
      );

  void _notifyChange() => widget.onChanged(
        ColorSelection(
          firstComponent: _firstValue,
          secondComponent: _secondValue,
          thirdComponent: _thirdValue,
        ),
      );
}
