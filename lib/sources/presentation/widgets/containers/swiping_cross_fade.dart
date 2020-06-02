import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:colored/sources/presentation/widgets/directional_pan_detector.dart';
import 'package:flutter/material.dart';

class SwipingCrossFade extends StatefulWidget {
  const SwipingCrossFade({
    @required this.header,
    @required this.child,
    this.showChild = true,
    this.enableGestures = true,
    this.sizeDuration,
    this.reverseFadeDuration,
    this.showFadeCurve,
    this.hideFadeCurve,
    this.sizeCurve,
    Key key,
  }) : super(key: key);

  final Widget child;
  final Widget header;
  final Duration sizeDuration;
  final Duration reverseFadeDuration;
  final Curve showFadeCurve;
  final Curve hideFadeCurve;
  final Curve sizeCurve;
  final bool showChild;
  final bool enableGestures;

  @override
  _SwipingCrossFadeState createState() => _SwipingCrossFadeState();
}

class _SwipingCrossFadeState extends State<SwipingCrossFade> {
  CrossFadeState _state;

  @override
  void initState() {
    _updateState();
    super.initState();
  }

  @override
  void didUpdateWidget(SwipingCrossFade oldWidget) {
    if (oldWidget.showChild != widget.showChild) {
      _updateState();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final durations = DurationData.of(context).durationScheme;
    final curves = CurveData.of(context).curveScheme;
    return DirectionalPanDetector(
      onPanUpdateUp: widget.enableGestures ? _show : null,
      onPanUpdateDown: widget.enableGestures ? _hide : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.transparent,
            child: widget.header,
          ),
          AnimatedCrossFade(
            crossFadeState: _state,
            firstChild: widget.child,
            secondChild: Container(),
            duration: widget.sizeDuration ?? durations.mediumPresenting,
            reverseDuration:
                widget.reverseFadeDuration ?? durations.mediumDismissing,
            firstCurve: widget.showFadeCurve ?? curves.incoming,
            secondCurve: widget.hideFadeCurve ?? curves.exiting,
            sizeCurve: widget.sizeCurve ?? curves.incoming,
          ),
        ],
      ),
    );
  }

  void _show(DragUpdateDetails details) =>
      setState(() => _state = CrossFadeState.showFirst);

  void _hide(DragUpdateDetails details) =>
      setState(() => _state = CrossFadeState.showSecond);

  void _updateState() => _state =
      widget.showChild ? CrossFadeState.showFirst : CrossFadeState.showSecond;
}
