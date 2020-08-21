import 'package:colored/sources/domain/view_models/lists/names_list/names_list_data.dart';
import 'package:colored/sources/domain/view_models/lists/names_list/names_list_state.dart';
import 'package:colored/sources/presentation/layouts/names_list/names_list_grid.dart';
import 'package:colored/sources/presentation/layouts/names_list/no_colors_message.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:flutter/material.dart';

class NamesListLayout extends StatelessWidget {
  const NamesListLayout({
    @required this.onColorCardPressed,
    Key key,
  })  : assert(onColorCardPressed != null),
        super(key: key);

  final void Function(Color) onColorCardPressed;

  @override
  Widget build(BuildContext context) {
    final state = NamesListData.of(context).state;
    switch (state.runtimeType) {
      case NoneFound:
        return const NoColorsMessage();
      case Found:
        final foundState = state as Found;
        return NamesListGrid(
          namedColors: foundState.namedColors,
          onCardPressed: onColorCardPressed,
        );
      default:
        return const BackgroundContainer();
    }
  }
}
