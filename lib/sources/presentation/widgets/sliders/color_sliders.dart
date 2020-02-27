import 'package:colored/sources/presentation/widgets/sliders/expandable_slider.dart';
import 'package:colored/sources/presentation/widgets/sliders/smooth_slider.dart';
import 'package:colored/sources/domain/data/color_selection.dart';
import 'package:colored/sources/styling/colors.dart' as colors;
import 'package:flutter/material.dart';

class ColorSliders extends StatefulWidget {
  const ColorSliders({
    @required this.firstValue,
    @required this.secondValue,
    @required this.thirdValue,
    @required this.onChanged,
    Key key,
  })  : assert(onChanged != null),
        super(key: key);

  final void Function(ColorSelection) onChanged;
  final double firstValue;
  final double secondValue;
  final double thirdValue;

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
              color: colors.red,
              availableWidth: constraints.maxWidth,
              onChanged: (value) {
                _firstValue = value;
                _notifyChange();
              },
            ),
            SmoothSlider(
              value: _secondValue,
              color: colors.green,
              onChanged: (value) {
                _secondValue = value;
                _notifyChange();
              },
            ),
            SmoothSlider(
              value: _thirdValue,
              color: colors.blue,
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
