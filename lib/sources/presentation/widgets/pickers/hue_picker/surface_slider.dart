import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const _kThumbSize = 20.0;

typedef ValueChanged = void Function(double, double);

class SurfaceSlider extends StatefulWidget {
  const SurfaceSlider({
    @required this.thumb,
    @required this.child,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    Key key,
  })  : assert(thumb != null),
        assert(child != null),
        super(key: key);

  final ValueChanged onChanged;
  final ValueChanged onChangeStart;
  final ValueChanged onChangeEnd;
  final Widget thumb;
  final Widget child;

  @override
  _SurfaceSliderState createState() => _SurfaceSliderState();
}

class _SurfaceSliderState extends State<SurfaceSlider> {
  Offset _thumbPosition;

  @override
  void initState() {
    _thumbPosition = Offset.zero;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          return RawGestureDetector(
            gestures: _buildGestures(width, height),
            child: Stack(
              children: [
                SizedBox.expand(child: widget.child),
                Positioned(
                  left: _thumbPosition.dx * width - _kThumbSize / 2,
                  top: _thumbPosition.dy * height - _kThumbSize / 2,
                  width: _kThumbSize,
                  height: _kThumbSize,
                  child: widget.thumb,
                ),
              ],
            ),
          );
        },
      );

  Map<Type, GestureRecognizerFactory> _buildGestures(double w, double h) => {
        _AcceptingRecognizer:
            GestureRecognizerFactoryWithHandlers<_AcceptingRecognizer>(
          () => _AcceptingRecognizer(),
          (recognizer) => _buildRecognizer(recognizer, w, h),
        ),
      };

  void _buildRecognizer(PanGestureRecognizer recognizer, double w, double h) =>
      recognizer
        ..onStart = ((d) => _onStart(d.globalPosition, context, h, w))
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
    _updateThumbAndNotify(normalized.dx, normalized.dy, widget.onChangeStart);
  }

  void _onUpdate(Offset offset, BuildContext context, double h, double w) {
    final normalized = _normalize(offset, context, h, w);
    _updateThumbAndNotify(normalized.dx, normalized.dy, widget.onChanged);
  }

  void _onEnd(BuildContext context, double h, double w) {
    final position = _thumbPosition;
    _updateThumbAndNotify(position.dx, position.dy, widget.onChangeEnd);
  }

  void _updateThumbAndNotify(double dx, double dy, ValueChanged notifier) {
    setState(() => _thumbPosition = Offset(dx, dy));
    if (notifier != null) {
      notifier(dx, dy);
    }
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
