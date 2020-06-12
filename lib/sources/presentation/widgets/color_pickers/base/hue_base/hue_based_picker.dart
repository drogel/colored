import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/base/hue_base/hue_based_selector.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/base/surface_color_picker.dart';
import 'package:flutter/material.dart';

class HueBasedPicker extends StatelessWidget {
  const HueBasedPicker({
    @required this.color,
    @required this.selector,
    @required this.constraints,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.track,
    Key key,
  })  : assert(color != null),
        assert(selector != null),
        assert(constraints != null),
        super(key: key);

  final BoxConstraints constraints;
  final Color color;
  final Widget track;
  final HueBasedSelector selector;
  final void Function(ColorSelection) onChanged;
  final void Function(ColorSelection) onChangeStart;
  final void Function(ColorSelection) onChangeEnd;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: constraints,
        child: SurfaceColorPicker(
          value: selector.pickValue(),
          color: color,
          track: track,
          onChanged: (x, y) => _note(selector.select(x, y), onChanged),
          onChangeStart: (x, y) => _note(selector.select(x, y), onChangeStart),
          onChangeEnd: (x, y) => _note(selector.select(x, y), onChangeEnd),
        ),
      );

  void _note(ColorSelection selection, void Function(ColorSelection) notifier) {
    if (notifier != null) {
      notifier(selection);
    }
  }
}
