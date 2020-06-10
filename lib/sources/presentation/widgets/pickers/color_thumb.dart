import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/opacity/opacity_constants.dart';
import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/common/extensions/is_dark_color.dart';
import 'package:flutter/material.dart';

class ColorThumb extends StatefulWidget {
  const ColorThumb({
    @required this.color,
    Key key,
  })  : assert(color != null),
        super(key: key);

  final Color color;

  @override
  _ColorThumbState createState() => _ColorThumbState();
}

class _ColorThumbState extends State<ColorThumb> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final elevation = ElevationData.of(context).elevationScheme;
    final duration = DurationData.of(context).durationScheme;
    final buttonColor = Theme.of(context).buttonColor;
    final textColor = Theme.of(context).appBarTheme.actionsIconTheme.color;
    final curves = CurveData.of(context).curveScheme;
    return GestureDetector(
      onPanDown: (_) => _showOuterRing(),
      onPanEnd: (_) => _hideOuterRing(),
      onTapUp: (_) => _hideOuterRing(),
      child: LayoutBuilder(
        builder: (_, constraints) => Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPadding(
              duration: duration.shortPresenting,
              curve: curves.main,
              padding: _getOuterPadding(constraints),
              child: AnimatedContainer(
                duration: duration.shortPresenting,
                curve: curves.main,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(constraints.maxHeight),
                  color: _getOuterColor(dark: buttonColor, light: textColor),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight / 3,
              width: constraints.maxWidth / 3,
              child: Material(
                animationDuration: duration.shortPresenting,
                elevation: _isPressed ? elevation.high : elevation.low,
                borderRadius: BorderRadius.circular(constraints.maxHeight),
                child: AnimatedContainer(
                  duration: duration.shortPresenting,
                  curve: curves.main,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(constraints.maxHeight),
                    color: _getThumbColor(dark: buttonColor, light: textColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  EdgeInsets _getOuterPadding(BoxConstraints constraints) =>
      _isPressed ? EdgeInsets.zero : EdgeInsets.all(constraints.maxHeight / 4);

  Color _getOuterColor({@required Color dark, @required Color light}) {
    final opacity = OpacityData.of(context).opacityScheme.fadedColor;
    final contrastingColor = _getContrastingColor(dark, light);
    final fadedContrastingColor = contrastingColor.withOpacity(opacity);
    return _isPressed ? widget.color : fadedContrastingColor;
  }

  Color _getContrastingColor(Color dark, Color light) {
    final contrastingColor = widget.color.isDark() ? light : dark;
    return contrastingColor;
  }

  Color _getThumbColor({@required Color dark, @required Color light}) =>
      _isPressed ? _getContrastingColor(dark, light) : widget.color;

  void _showOuterRing() => setState(() => _isPressed = true);

  void _hideOuterRing() => setState(() => _isPressed = false);
}
