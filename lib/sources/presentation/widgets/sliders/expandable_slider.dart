import 'package:colored/sources/presentation/widgets/sliders/smooth_slider.dart';
import 'package:colored/sources/styling/opacities.dart' as opacities;
import 'package:colored/sources/styling/durations.dart' as durations;
import 'package:colored/sources/styling/curves.dart' as curves;
import 'package:flutter/cupertino.dart';

const _kExpandedAddedWidth = 64;

class ExpandableSlider extends StatefulWidget {
  const ExpandableSlider({
    @required this.value,
    @required this.color,
    @required this.onChanged,
    @required this.availableWidth,
    this.duration = durations.mediumPresenting,
    this.expansionDuration = durations.smallPresenting,
    this.curve = curves.primary,
    this.inactiveOpacity = opacities.fadedColor,
    Key key,
  })  : assert(onChanged != null),
        assert(duration != null),
        assert(inactiveOpacity != null),
        super(key: key);

  final double value;
  final Color color;
  final double inactiveOpacity;
  final double availableWidth;
  final void Function(double) onChanged;
  final Duration duration;
  final Duration expansionDuration;
  final Curve curve;

  @override
  _ExpandableSliderState createState() => _ExpandableSliderState();
}

class _ExpandableSliderState extends State<ExpandableSlider>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController _expansionController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _expansionController = AnimationController(
      vsync: this,
      duration: widget.expansionDuration,
      value: widget.availableWidth,
      lowerBound: widget.availableWidth,
      upperBound: widget.availableWidth + _kExpandedAddedWidth,
    );
    _expansionController.addListener(_updateWidth);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onLongPress: _toggleExpansion,
        child: LayoutBuilder(
          builder: (_, constraints) => SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              width: _expansionController.value,
              child: SmoothSlider(
                value: widget.value,
                color: widget.color,
                inactiveOpacity: widget.inactiveOpacity,
                onChanged: widget.onChanged,
                duration: widget.duration,
                curve: widget.curve,
              ),
            ),
          ),
        ),
      );

  void _updateWidth() {
    setState(() {});
    _scrollController.jumpTo(
      (_expansionController.value - widget.availableWidth) * widget.value,
    );
  }

  void _toggleExpansion() {
    if (_expansionController.status == AnimationStatus.dismissed) {
      _expansionController.forward();
    } else {
      _expansionController.reverse();
    }
  }
}
