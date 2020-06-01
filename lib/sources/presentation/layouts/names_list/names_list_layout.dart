import 'package:colored/sources/app/styling/padding/padding_constants.dart' as paddings;
import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_data.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_state.dart';
import 'package:colored/sources/presentation/layouts/names_list/names_list_grid.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:flutter/material.dart';

class NamesListLayout extends StatelessWidget {
  const NamesListLayout({this.onColorCardPressed, Key key}) : super(key: key);

  final void Function(Color) onColorCardPressed;

  @override
  Widget build(BuildContext context) {
    final state = NamesListData.of(context).state;
    switch (state.runtimeType) {
      case NoneFound:
        return _buildNoneFoundStateLayout(context);
      case Found:
        final foundState = state as Found;
        return _buildFoundStateLayout(foundState);
      default:
        return const BackgroundContainer();
    }
  }

  Widget _buildFoundStateLayout(Found foundState) => NamesListGrid(
        namedColors: foundState.namedColors,
        onCardPressed: onColorCardPressed,
      );

  Widget _buildNoneFoundStateLayout(BuildContext context) {
    final localization = Localization.of(context).namesList;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.symmetric(
        horizontal: paddings.base,
        vertical: paddings.base / 2,
      ),
      child: Text(localization.noColorsFound),
    );
  }
}
