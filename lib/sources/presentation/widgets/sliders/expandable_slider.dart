import 'package:colored/sources/presentation/widgets/sliders/smooth_slider.dart';
import 'package:colored/sources/styling/opacities.dart' as opacities;
import 'package:colored/sources/styling/durations.dart' as durations;
import 'package:colored/sources/styling/curves.dart' as curves;
import 'package:flutter/cupertino.dart';

const _kExpandedAddedWidth = 1000;
const _kExpandedValueFactor = 6;
const _kExpandedDivisions = 255 ~/ _kExpandedValueFactor;
const _kExpandedScrollingFactor = 1.1;
const _kDefaultMin = 0.0;
const _kDefaultMax = 1.0;
const _kScrollingStep = 32;

class ExpandableSlider extends StatefulWidget {
  const ExpandableSlider({
    @required this.value,
    @required this.color,
    @required this.onChanged,
    @required this.availableWidth,
    this.duration = durations.mediumPresenting,
    this.expansionDuration = durations.smallPresenting,
    this.shrinkingDuration = durations.smallDismissing,
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
  final Duration shrinkingDuration;
  final Curve curve;

  @override
  _ExpandableSliderState createState() => _ExpandableSliderState();
}

class _ExpandableSliderState extends State<ExpandableSlider>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController _expansionController;
  Animation<double> _expansionAnimation;
  double _max = _kDefaultMax;
  double _min = _kDefaultMin;
  int _divisions;

  @override
  void initState() {
    _scrollController = ScrollController();
    _expansionController = AnimationController(
      vsync: this,
      duration: widget.expansionDuration,
      reverseDuration: widget.shrinkingDuration,
    );
    _expansionAnimation =
        Tween<double>(begin: _kDefaultMin, end: _kDefaultMax).animate(
      CurvedAnimation(
        parent: _expansionController,
        curve: curves.primary,
      ),
    );
    _expansionAnimation.addListener(_updateExpansionTransition);
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
                  _expansionAnimation.value * _kExpandedAddedWidth,
              child: SmoothSlider(
                value: widget.value,
                color: widget.color,
                inactiveOpacity: widget.inactiveOpacity,
                onChanged: _onChanged,
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

  bool get _isExpanded => _max != _kDefaultMax && _min != _kDefaultMin;

  void _onChanged(double newValue) {
    _shouldScroll(newValue);
    widget.onChanged(newValue);
  }

  void _shouldScroll(double newValue) {
    if (_isExpanded) {
      final totalWidth = widget.availableWidth + _kExpandedAddedWidth;
      final scrollPosition = _scrollController.position.pixels;
      final relativeMin = scrollPosition / totalWidth;
      final relativeMax = (scrollPosition + widget.availableWidth) / totalWidth;
      final minDiff = (_min - relativeMin).clamp(_kDefaultMin, _kDefaultMax);
      final maxDiff = (relativeMax - _max).clamp(_kDefaultMin, _kDefaultMax);

      if (minDiff * _kExpandedScrollingFactor + _min > newValue) {
        _scrollController.animateTo(
          scrollPosition - _kScrollingStep,
          duration: durations.smallPresenting,
          curve: curves.primary,
        );
      } else if (_max - maxDiff * _kExpandedScrollingFactor < newValue) {
        _scrollController.animateTo(
          scrollPosition + _kScrollingStep,
          duration: durations.smallPresenting,
          curve: curves.primary,
        );
      }
    }
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
    final expansionValue = _expansionAnimation.value;
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
