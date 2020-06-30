import 'package:colored/sources/domain/view_models/transformer/transformer_state.dart';
import 'package:flutter/material.dart';

class TransformerData extends InheritedWidget {
  const TransformerData({
    @required this.state,
    @required this.onColorSwipedVertical,
    @required this.onColorSwipedHorizontal,
    @required Widget child,
    Key key,
  })  : assert(state != null),
        assert(child != null),
        super(key: key, child: child);

  final TransformerState state;
  final void Function(double) onColorSwipedVertical;
  final void Function(double) onColorSwipedHorizontal;

  static TransformerData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: TransformerData);

  @override
  bool updateShouldNotify(TransformerData oldWidget) =>
      state != oldWidget.state;
}
