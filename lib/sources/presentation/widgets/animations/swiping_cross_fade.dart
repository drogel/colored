import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/presentation/widgets/containers/draggable_indicator.dart';
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
    this.hasIndicator = true,
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
  final bool hasIndicator;

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
    final padding = PaddingData.of(context).paddingScheme;
    return DirectionalPanDetector(
      onPanUpdateUp: widget.enableGestures ? (_) => _show() : null,
      onPanUpdateDown: widget.enableGestures ? (_) => _hide() : null,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.header,
              AnimatedCrossFade(
                crossFadeState: _state,
                firstChild: widget.child,
                secondChild: Container(
                  height: padding.large.bottom + padding.small.bottom,
                ),
                duration: widget.sizeDuration ?? durations.mediumDismissing,
                reverseDuration:
                    widget.reverseFadeDuration ?? durations.shortDismissing,
                firstCurve: widget.showFadeCurve ?? curves.incoming,
                secondCurve: widget.hideFadeCurve ?? curves.incoming,
                sizeCurve: widget.sizeCurve ?? curves.incoming,
              ),
            ],
          ),
          if (widget.hasIndicator && widget.showChild)
            Padding(
              padding: padding.small,
              child: DraggableIndicator(onTap: _toggle),
            ),
        ],
      ),
    );
  }

  void _show() => setState(() => _state = CrossFadeState.showFirst);

  void _hide() => setState(() => _state = CrossFadeState.showSecond);

  void _updateState() => _state =
      widget.showChild ? CrossFadeState.showFirst : CrossFadeState.showSecond;

  void _toggle() => _state == CrossFadeState.showFirst ? _hide() : _show();
}
