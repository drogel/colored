import 'package:colored/sources/presentation/widgets/sliders/smooth_slider.dart';
import 'package:colored/sources/styling/opacities.dart' as opacities;
import 'package:colored/sources/styling/durations.dart' as durations;
import 'package:colored/sources/styling/curves.dart' as curves;
import 'package:flutter/cupertino.dart';

const _kExpandedAddedWidth = 1000;
const _kExpandedValueFactor = 6;
const _kExpandedDivisions = 255 ~/ _kExpandedValueFactor;
const _kDefaultMin = 0.0;
const _kDefaultMax = 1.0;

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
  double _max = _kDefaultMax;
  double _min = _kDefaultMin;
  int _divisions;

  @override
  void initState() {
    _scrollController = ScrollController();
    _expansionController = AnimationController(
      vsync: this,
      duration: widget.expansionDuration
    );
    _expansionController.addListener(_updateExpansionTransition);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onScaleUpdate: _toggleExpansion,
        child: LayoutBuilder(
          builder: (_, constraints) => SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              width: widget.availableWidth +
                  _expansionController.value * _kExpandedAddedWidth,
              child: SmoothSlider(
                value: widget.value,
                color: widget.color,
                inactiveOpacity: widget.inactiveOpacity,
                onChanged: widget.onChanged,
                duration: widget.duration,
                curve: widget.curve,
                max: _max,
                min: _min,
                divisions: _divisions,
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _expansionController.dispose();
    super.dispose();
  }

  void _toggleExpansion(ScaleUpdateDetails details) {
    if (details.horizontalScale > 1) {
      _shouldExpand();
    } else if (details.horizontalScale < 1) {
      _shouldShrink();
    }
  }

  void _updateExpansionTransition() {
    final fixedWidth = widget.availableWidth;
    final expansionValue = _expansionController.value;
    final currentWidth = fixedWidth + expansionValue * _kExpandedAddedWidth;
    _scrollController.jumpTo((currentWidth - fixedWidth) * widget.value);
    setState(() => _divisions = _kExpandedDivisions);
    if (_expansionController.status == AnimationStatus.completed) {
      _setExpandedRange();
    } else if (_expansionController.status == AnimationStatus.dismissed) {
      _setDefaultRange();
    }
  }

  void _setExpandedRange() {
    final min = widget.value * (1 - 1 / _kExpandedValueFactor);
    final max = widget.value + (1 - widget.value) / _kExpandedValueFactor;
    setState(() {
      _min = min < 0.01 ? 0 : min;
      _max = max > 0.99 ? 1 : max;
    });
  }

  void _setDefaultRange() => setState(() {
        _min = _kDefaultMin;
        _max = _kDefaultMax;
        _divisions = null;
      });

  void _shouldExpand() {
    if (_expansionController.status == AnimationStatus.dismissed) {
      _expansionController.forward();
    }
  }

  void _shouldShrink() {
    if (_expansionController.status == AnimationStatus.completed) {
      _expansionController.reverse();
    }
  }
}
