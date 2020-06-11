import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef ValueChanged = void Function(double, double);

class SurfaceSlider extends StatefulWidget {
  const SurfaceSlider({
    @required this.thumbBuilder,
    @required this.child,
    @required this.value,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    Key key,
  })  : assert(thumbBuilder != null),
        assert(child != null),
        assert(value != null),
        super(key: key);

  final ValueChanged onChanged;
  final ValueChanged onChangeStart;
  final ValueChanged onChangeEnd;
  final Offset value;
  final Widget Function(bool) thumbBuilder;
  final Widget child;

  @override
  _SurfaceSliderState createState() => _SurfaceSliderState();
}

class _SurfaceSliderState extends State<SurfaceSlider> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) {
          final duration = DurationData.of(context).durationScheme;
          final curves = CurveData.of(context).curveScheme;
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          const sliderThumbShape = RoundSliderThumbShape();
          final thumbSize = 5 * sliderThumbShape.enabledThumbRadius;
          return MouseRegion(
            onEnter: (_) => _setPressed(),
            onExit: (_) => _setUnpressed(),
            child: RawGestureDetector(
              gestures: _buildGestures(width, height),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  SizedBox.expand(child: widget.child),
                  AnimatedPositioned(
                    duration: duration.shortPresenting,
                    curve: curves.incoming,
                    left: widget.value.dx * width - thumbSize / 2,
                    top: widget.value.dy * height - thumbSize / 2,
                    width: thumbSize,
                    height: thumbSize,
                    child: widget.thumbBuilder(_isPressed),
                  ),
                ],
              ),
            ),
          );
        },
      );

  Map<Type, GestureRecognizerFactory> _buildGestures(double w, double h) => {
        _MultiChildRecognizer:
            GestureRecognizerFactoryWithHandlers<_MultiChildRecognizer>(
          () => _MultiChildRecognizer(),
          (recognizer) => _buildRecognizer(recognizer, w, h),
        ),
      };

  void _buildRecognizer(PanGestureRecognizer recognizer, double w, double h) =>
      recognizer
        ..onStart = ((d) => _onStart(d.globalPosition, context, h, w))
        ..onDown = ((d) => _onStart(d.globalPosition, context, h, w))
        ..onEnd = ((d) => _onEnd(context, h, w))
        ..onCancel = _setUnpressed
        ..onUpdate = ((d) => _onUpdate(d.globalPosition, context, h, w));

  Offset _normalize(Offset offset, BuildContext context, double h, double w) {
    RenderBox getBox = context.findRenderObject();
    final localOffset = getBox.globalToLocal(offset);
    final dx = localOffset.dx.clamp(0, w) / w;
    final dy = localOffset.dy.clamp(0, h) / h;
    return Offset(dx, dy);
  }

  void _onStart(Offset offset, BuildContext context, double h, double w) {
    final normalized = _normalize(offset, context, h, w);
    _setPressed();
    _shouldNotify(normalized.dx, normalized.dy, widget.onChangeStart);
  }

  void _onUpdate(Offset offset, BuildContext context, double h, double w) {
    final normalized = _normalize(offset, context, h, w);
    _shouldNotify(normalized.dx, normalized.dy, widget.onChanged);
  }

  void _onEnd(BuildContext context, double h, double w) {
    final position = widget.value;
    _setUnpressed();
    _shouldNotify(position.dx, position.dy, widget.onChangeEnd);
  }

  void _shouldNotify(double dx, double dy, ValueChanged notifier) {
    if (notifier != null) {
      notifier(dx, dy);
    }
  }

  void _setPressed() => setState(() => _isPressed = true);

  void _setUnpressed() => setState(() => _isPressed = false);
}

class _MultiChildRecognizer extends PanGestureRecognizer {
  @override
  void rejectGesture(int pointer) => acceptGesture(pointer);

  @override
  String get debugDescription => '_MultiChildRecognizer';
}
