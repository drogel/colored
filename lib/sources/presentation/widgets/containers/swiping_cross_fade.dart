import 'package:colored/sources/presentation/widgets/directional_pan_detector.dart';
import 'package:colored/sources/app/styling/curves.dart' as curves;
import 'package:colored/sources/app/styling/durations.dart' as durations;
import 'package:flutter/material.dart';

class SwipingCrossFade extends StatefulWidget {
  const SwipingCrossFade({
    @required this.header,
    @required this.child,
    this.alwaysShowChild = false,
    this.showChild = true,
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
  final bool showChild;
  final bool alwaysShowChild;

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
            _buildChild(),
          ],
        ),
      );

  void _show(DragUpdateDetails details) =>
      setState(() => _state = CrossFadeState.showFirst);

  void _hide(DragUpdateDetails details) =>
      setState(() => _state = CrossFadeState.showSecond);

  Widget _buildChild() => widget.alwaysShowChild
      ? widget.child
      : AnimatedCrossFade(
          crossFadeState: _state,
          firstChild: widget.child,
          secondChild: Container(),
          duration: widget.sizeDuration,
          reverseDuration: widget.reverseFadeDuration,
          firstCurve: widget.showFadeCurve,
          secondCurve: widget.hideFadeCurve,
          sizeCurve: widget.sizeCurve,
        );

  void _updateState() => _state =
      widget.showChild ? CrossFadeState.showFirst : CrossFadeState.showSecond;
}
