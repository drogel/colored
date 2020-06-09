import 'package:colored/sources/presentation/widgets/pickers/color_indicator.dart';
import 'package:colored/sources/presentation/widgets/pickers/hsv_picker/hsv_canvas.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const _kIndicatorSize = 48.0;

class HsvPicker extends StatefulWidget {
  const HsvPicker({
    @required this.color,
    Key key,
  })  : assert(color != null),
        super(key: key);

  final Color color;

  @override
  _HsvPickerState createState() => _HsvPickerState();
}

class _HsvPickerState extends State<HsvPicker> {
  double _left = 0;
  double _bottom = 0;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          return RawGestureDetector(
            gestures: _gestures(width, height),
            child: Stack(
              children: [
                HsvCanvas(color: widget.color),
                Positioned(
                  left: _left * width - _kIndicatorSize / 2,
                  bottom: _bottom * height - _kIndicatorSize / 2,
                  child: const ColorIndicator(
                    color: Colors.white,
                    outerColor: Colors.black,
                    size: _kIndicatorSize,
                  ),
                ),
              ],
            ),
          );
        },
      );

  Map<Type, GestureRecognizerFactory> _gestures(double width, double height) =>
      {
        _AcceptingRecognizer:
            GestureRecognizerFactoryWithHandlers<_AcceptingRecognizer>(
          () => _AcceptingRecognizer(),
          (recognizer) => _handle(recognizer, width, height),
        ),
      };

  void _handle(PanGestureRecognizer recognizer, double w, double h) =>
      recognizer
        ..onDown = ((d) => _handleGesture(d.globalPosition, context, h, w))
        ..onUpdate = ((d) => _handleGesture(d.globalPosition, context, h, w));

  void _handleColorChange(double horizontal, double vertical) {
    setState(() {
      _left = horizontal;
      _bottom = vertical;
    });
  }

  void _handleGesture(Offset offset, BuildContext context, double h, double w) {
    RenderBox getBox = context.findRenderObject();
    final localOffset = getBox.globalToLocal(offset);
    final horizontal = localOffset.dx.clamp(0, w) / w;
    final vertical = 1 - localOffset.dy.clamp(0, h) / h;
    _handleColorChange(horizontal, vertical);
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
