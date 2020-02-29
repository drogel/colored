import 'package:colored/sources/presentation/widgets/no_glow_behavior.dart';
import 'package:colored/sources/presentation/widgets/sliders/smooth_slider.dart';
import 'package:colored/sources/styling/opacities.dart' as opacities;
import 'package:colored/sources/styling/durations.dart' as durations;
import 'package:colored/sources/styling/curves.dart' as curves;
import 'package:flutter/cupertino.dart';

const _kExpandedAddedWidth = 6000;
const _kExpandedDivisions = 255;
const _kExpandedScrollingFactor = 1.02;
const _kDefaultMin = 0.0;
const _kDefaultMax = 1.0;
const _kScrollingStep = 40;

class ExpandableSlider extends StatefulWidget {
  const ExpandableSlider({
    @required this.value,
    @required this.color,
    @required this.onChanged,
    @required this.availableWidth,
    this.duration = durations.smallPresenting,
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
  final _max = _kDefaultMax;
  final _min = _kDefaultMin;

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
          builder: (_, constraints) => ScrollConfiguration(
            behavior: const NoGlowBehavior(),
            child: SingleChildScrollView(
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
                  divisions: _kExpandedDivisions,
                ),
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

  void _onChanged(double newValue) {
    _shouldScroll(newValue);
    widget.onChanged(newValue);
  }

  void _shouldScroll(double newValue) {
    if (_expansionController.status == AnimationStatus.completed) {
      final totalWidth = widget.availableWidth + _kExpandedAddedWidth;
      final scrollPosition = _scrollController.position.pixels;
      final screenMin = scrollPosition / totalWidth;
      final screenMax = (scrollPosition + widget.availableWidth) / totalWidth;
      final minDiff = (screenMin - _min).clamp(_kDefaultMin, _kDefaultMax);
      final maxDiff = (_max - screenMax).clamp(_kDefaultMin, _kDefaultMax);
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
    setState(() {});
    _scrollController.jumpTo((currentWidth - fixedWidth) * widget.value);
  }

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
