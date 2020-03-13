import 'package:colored/sources/presentation/widgets/directional_pan_detector.dart';
import 'package:colored/sources/styling/curves.dart' as curves;
import 'package:colored/sources/styling/durations.dart' as durations;
import 'package:flutter/material.dart';

class SwipingCrossFade extends StatefulWidget {
  const SwipingCrossFade({
    @required this.header,
    @required this.child,
    this.initialState = CrossFadeState.showFirst,
    this.duration = durations.shortPresenting,
    this.reverseDuration = durations.shortDismissing,
    this.showCurve = curves.incoming,
    this.hideCurve = curves.exiting,
    this.sizeCurve = curves.incoming,
    Key key,
  }) : super(key: key);

  final Widget child;
  final Widget header;
  final Duration duration;
  final Duration reverseDuration;
  final Curve showCurve;
  final Curve hideCurve;
  final Curve sizeCurve;
  final CrossFadeState initialState;

  @override
  _SwipingCrossFadeState createState() => _SwipingCrossFadeState();
}

class _SwipingCrossFadeState extends State<SwipingCrossFade> {
  CrossFadeState _state;

  @override
  void initState() {
    _state = widget.initialState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DirectionalPanDetector(
        onPanUpdateUp: _show,
        onPanUpdateDown: _hide,
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
              duration: widget.duration,
              reverseDuration: widget.reverseDuration,
              firstCurve: widget.showCurve,
              secondCurve: widget.hideCurve,
              sizeCurve: widget.sizeCurve,
            ),
          ],
        ),
      );

  void _show(DragUpdateDetails details) =>
      setState(() => _state = CrossFadeState.showFirst);

  void _hide(DragUpdateDetails details) =>
      setState(() => _state = CrossFadeState.showSecond);
}
