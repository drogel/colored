import 'package:colored/sources/domain/view_models/transformer/transformer_data.dart';
import 'package:colored/sources/presentation/widgets/containers/swiping_color_container.dart';
import 'package:flutter/material.dart';

class TransformerLayout extends StatelessWidget {
  const TransformerLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = TransformerData.of(context);
    return SwipingColorContainer(
      color: data.state.selection.toColor(),
      onColorSwipedVertical: data.onColorSwipedVertical,
      onColorSwipedHorizontal: data.onColorSwipedHorizontal,
      onColorSwipeEnd: () => data.onSelectionEnd(data.state.selection),
    );
  }
}
