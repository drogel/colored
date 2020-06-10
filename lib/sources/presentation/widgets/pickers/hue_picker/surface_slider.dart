import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef ValueChanged = void Function(double, double);

class SurfaceSlider extends StatefulWidget {
  const SurfaceSlider({
    @required this.thumb,
    @required this.child,
    @required this.value,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    Key key,
  })  : assert(thumb != null),
        assert(child != null),
        assert(value != null),
        super(key: key);

  final ValueChanged onChanged;
  final ValueChanged onChangeStart;
  final ValueChanged onChangeEnd;
  final Offset value;
  final Widget thumb;
  final Widget child;

  @override
  _SurfaceSliderState createState() => _SurfaceSliderState();
}

class _SurfaceSliderState extends State<SurfaceSlider> {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          const sliderThumbShape = RoundSliderThumbShape();
          final thumbSize = 6 * sliderThumbShape.enabledThumbRadius;
          return RawGestureDetector(
            gestures: _buildGestures(width, height),
            child: Stack(
              children: [
                SizedBox.expand(child: widget.child),
                Positioned(
                  left: widget.value.dx * width - thumbSize / 2,
                  top: widget.value.dy * height - thumbSize / 2,
                  width: thumbSize,
                  height: thumbSize,
                  child: widget.thumb,
                ),
              ],
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
        ..onDown = ((d) => _onUpdate(d.globalPosition, context, h, w))
        ..onEnd = ((d) => _onEnd(context, h, w))
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
    _shouldNotify(normalized.dx, normalized.dy, widget.onChangeStart);
  }

  void _onUpdate(Offset offset, BuildContext context, double h, double w) {
    final normalized = _normalize(offset, context, h, w);
    _shouldNotify(normalized.dx, normalized.dy, widget.onChanged);
  }

  void _onEnd(BuildContext context, double h, double w) {
    final position = widget.value;
    _shouldNotify(position.dx, position.dy, widget.onChangeEnd);
  }

  void _shouldNotify(double dx, double dy, ValueChanged notifier) {
    if (notifier != null) {
      notifier(dx, dy);
    }
  }
}

class _MultiChildRecognizer extends PanGestureRecognizer {
  @override
  void rejectGesture(int pointer) => acceptGesture(pointer);

  @override
  String get debugDescription => 'AcceptingRecognizer';
}
