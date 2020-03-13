import 'package:colored/sources/presentation/widgets/directional_pan_detector.dart';
import 'package:colored/sources/styling/curves.dart' as curves;
import 'package:colored/sources/styling/durations.dart' as durations;
import 'package:flutter/material.dart';

class SwipingCrossFade extends StatefulWidget {
  const SwipingCrossFade({
    @required this.header,
    @required this.child,
    this.isChildInitiallyShown = true,
    this.sizeDuration = durations.mediumDismissing,
    this.reverseFadeDuration = durations.shortDismissing,
    this.showFadeCurve = curves.incoming,
    this.hideFadeCurve = curves.exiting,
    this.sizeCurve = curves.incoming,
    Key key,
  }) : super(key: key);

  final Widget child;
  final Widget header;
  final Duration sizeDuration;
  final Duration reverseFadeDuration;
  final Curve showFadeCurve;
  final Curve hideFadeCurve;
  final Curve sizeCurve;
  final bool isChildInitiallyShown;

  @override
  _SwipingCrossFadeState createState() => _SwipingCrossFadeState();
}

class _SwipingCrossFadeState extends State<SwipingCrossFade> {
  CrossFadeState _state;

  @override
  void initState() {
    _state = widget.isChildInitiallyShown
        ? CrossFadeState.showFirst
        : CrossFadeState.showSecond;
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
              duration: widget.sizeDuration,
              reverseDuration: widget.reverseFadeDuration,
              firstCurve: widget.showFadeCurve,
              secondCurve: widget.hideFadeCurve,
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
