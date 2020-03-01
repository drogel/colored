import 'package:colored/sources/presentation/widgets/no_glow_behavior.dart';
import 'package:colored/sources/presentation/widgets/sliders/smooth_slider.dart';
import 'package:colored/sources/styling/opacities.dart' as opacities;
import 'package:colored/sources/styling/durations.dart' as durations;
import 'package:colored/sources/styling/curves.dart' as curves;
import 'package:flutter/material.dart';

const _kExpandedAddedWidth = 6000;
const _kExpandedDivisions = 255;
const _kExpandedScrollingFactor = 1.02;
const _kScrollTriggerFactor = 0.86;
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
    this.expansionDuration = durations.mediumPresenting,
    this.shrinkingDuration = durations.mediumDismissing,
    this.curve = curves.main,
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
  final _max = _kDefaultMax;
  final _min = _kDefaultMin;
  final ScrollController _scroll = ScrollController();

  AnimationController _expansion;
  Animation<double> _expansionAnimation;
  AnimationStatus _previousStatus;
  double _expansionFocalValue;

  @override
  void initState() {
    _expansion = AnimationController(
      vsync: this,
      duration: widget.expansionDuration,
      reverseDuration: widget.shrinkingDuration,
    );
    _expansionAnimation =
        Tween<double>(begin: _kDefaultMin, end: _kDefaultMax).animate(
      CurvedAnimation(
        parent: _expansion,
        curve: curves.exiting,
        reverseCurve: curves.incoming,
      ),
    );
    _expansionAnimation.addListener(_updateExpansionTransition);
    _expansionAnimation.addStatusListener((_) => _updateExpansionFocalValue());
    _scroll.addListener(_updateExpansionFocalValue);
    _previousStatus = _expansion.status;
    _updateExpansionFocalValue();
    super.initState();
  }

  @override
  void didUpdateWidget(ExpandableSlider oldWidget) {
    final change = (oldWidget.value - widget.value).abs() * _totalWidth;
    if (change > widget.availableWidth * _kScrollTriggerFactor && _isExpanded) {
      _scroll.animateTo(
        widget.value * _totalWidth - widget.availableWidth / 2,
        duration: durations.largePresenting,
        curve: curves.main,
      );
    }
    if (oldWidget.value != widget.value && _isShrunk) {
      _updateExpansionFocalValue();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onScaleUpdate: _toggleExpansionOnScale,
        onLongPress: _toggleExpansionOnPress,
        child: LayoutBuilder(
          builder: (_, constraints) => ScrollConfiguration(
            behavior: const NoGlowBehavior(),
            child: SingleChildScrollView(
              controller: _scroll,
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
    _expansion.dispose();
    super.dispose();
  }

  bool get _isExpanded => _expansion.status == AnimationStatus.completed;

  bool get _isShrunk => _expansion.status == AnimationStatus.dismissed;

  double get _totalWidth => widget.availableWidth + _kExpandedAddedWidth;

  bool get _isCompleteForwarding =>
      _expansion.status == AnimationStatus.forward ||
      (_isExpanded && _previousStatus == AnimationStatus.forward);

  void _onChanged(double newValue) {
    _shouldScroll(newValue);
    widget.onChanged(newValue);
  }

  void _updateExpansionFocalValue() {
    if (_isExpanded) {
      _expansionFocalValue = _scroll.position.pixels;
    } else if (_isShrunk) {
      _expansionFocalValue = widget.value;
    }
  }

  void _shouldScroll(double newValue) {
    if (_isExpanded) {
      final scrollPosition = _scroll.position.pixels;
      final screenMin = scrollPosition / _totalWidth;
      final screenMax = (scrollPosition + widget.availableWidth) / _totalWidth;
      final minDiff = (screenMin - _min).clamp(_kDefaultMin, _kDefaultMax);
      final maxDiff = (_max - screenMax).clamp(_kDefaultMin, _kDefaultMax);
      if (minDiff * _kExpandedScrollingFactor + _min > newValue) {
        _scroll.animateTo(
          scrollPosition - _kScrollingStep,
          duration: durations.smallPresenting,
          curve: curves.main,
        );
      } else if (_max - maxDiff * _kExpandedScrollingFactor < newValue) {
        _scroll.animateTo(
          scrollPosition + _kScrollingStep,
          duration: durations.smallPresenting,
          curve: curves.main,
        );
      }
    }
  }

  void _toggleExpansionOnScale(ScaleUpdateDetails details) {
    if (details.horizontalScale > 1 && _isShrunk) {
      _expand();
    } else if (details.horizontalScale < 1 && _isExpanded) {
      _shrink();
    }
  }

  void _toggleExpansionOnPress() => _isExpanded ? _shrink() : _expand();

  void _updateExpansionTransition() {
    final expansionValue = _expansionAnimation.value;
    final addedWidth = expansionValue * _kExpandedAddedWidth;
    if (_isCompleteForwarding) {
      setState(() => _scroll.jumpTo(_expansionFocalValue * addedWidth));
    } else {
      setState(() => _scroll.jumpTo(_expansionFocalValue * expansionValue));
    }
    _previousStatus = _expansion.status;
  }

  void _expand() => _expansion.forward();

  void _shrink() => _expansion.reverse();
}
