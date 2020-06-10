import 'package:colored/sources/presentation/widgets/pickers/color_indicator.dart';
import 'package:colored/sources/common/extensions/is_dark_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const _kIndicatorSize = 48.0;

class HuePicker extends StatefulWidget {
  const HuePicker({
    @required this.color,
    @required this.hueCanvas,
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

  @override
  _HuePickerState createState() => _HuePickerState();
}

class _HuePickerState extends State<HuePicker> {
  Offset _indicatorPosition;

  @override
  void initState() {
    _indicatorPosition = Offset.zero;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryVariant = theme.colorScheme.primaryVariant;
    final textColor = theme.textTheme.bodyText2.color;
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return RawGestureDetector(
          gestures: _buildGestures(width, height),
          child: Stack(
            children: [
              SizedBox.expand(child: widget.hueCanvas),
              Positioned(
                left: _indicatorPosition.dx * width - _kIndicatorSize / 2,
                top: _indicatorPosition.dy * height - _kIndicatorSize / 2,
                child: ColorIndicator(
                  color: widget.color,
                  outerColor: _getOuterColor(primaryVariant, textColor),
                  size: _kIndicatorSize,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getOuterColor(Color primaryVariant, Color textColor) {
    final outerDarkColor = widget.indicatorDarkOuterColor ?? primaryVariant;
    final outerLightColor = widget.indicatorLightOuterColor ?? textColor;
    return widget.color.isDark() ? outerLightColor : outerDarkColor;
  }

  Map<Type, GestureRecognizerFactory> _buildGestures(double w, double h) => {
        _AcceptingRecognizer:
            GestureRecognizerFactoryWithHandlers<_AcceptingRecognizer>(
          () => _AcceptingRecognizer(),
          (recognizer) => _buildRecognizer(recognizer, w, h),
        ),
      };

  void _buildRecognizer(PanGestureRecognizer recognizer, double w, double h) =>
      recognizer
        ..onDown = ((d) => _handleGesture(d.globalPosition, context, h, w))
        ..onUpdate = ((d) => _handleGesture(d.globalPosition, context, h, w));

  void _handleColorChange(double dx, double dy) =>
      setState(() => _indicatorPosition = Offset(dx, dy));

  void _handleGesture(Offset offset, BuildContext context, double h, double w) {
    RenderBox getBox = context.findRenderObject();
    final localOffset = getBox.globalToLocal(offset);
    final dx = localOffset.dx.clamp(0, w) / w;
    final dy = localOffset.dy.clamp(0, h) / h;
    _handleColorChange(dx, dy);
  }
}

class _AcceptingRecognizer extends PanGestureRecognizer {
  @override
  void addAllowedPointer(PointerEvent event) {
    super.addAllowedPointer(event);
    resolve(GestureDisposition.accepted);
  }

  @override
  String get debugDescription => 'AcceptingRecognizer';
}
