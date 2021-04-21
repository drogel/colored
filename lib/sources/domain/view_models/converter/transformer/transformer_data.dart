import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_state.dart';
import 'package:flutter/material.dart';

class TransformerData extends InheritedWidget {
  const TransformerData({
    required this.state,
    required this.onColorSwipedVertical,
    required this.onColorSwipedHorizontal,
    required this.onSelectionChanged,
    required this.onSelectionStarted,
    required this.onSelectionEnded,
    required Widget child,
    Key? key,
  })  : assert(state != null),
        assert(child != null),
        super(key: key, child: child);

  final TransformerState state;
  final void Function(ColorSelection) onSelectionChanged;
  final void Function(ColorSelection) onSelectionEnded;
  final void Function(ColorSelection) onSelectionStarted;
  final void Function(double) onColorSwipedVertical;
  final void Function(double) onColorSwipedHorizontal;

  static TransformerData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: TransformerData);

  @override
  bool updateShouldNotify(TransformerData oldWidget) =>
      state != oldWidget.state;
}
