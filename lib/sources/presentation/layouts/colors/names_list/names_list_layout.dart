import 'package:colored/sources/domain/view_models/colors/names_list/names_list_data.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_state.dart';
import 'package:colored/sources/presentation/layouts/colors/names_list/names_grid.dart';
import 'package:colored/sources/presentation/layouts/colors/names_list/no_colors_message.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:flutter/material.dart';

class NamesListLayout extends StatelessWidget {
  const NamesListLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = NamesListData.of(context)!;
    final state = data.state;
    switch (state.runtimeType) {
      case NoneFound:
        return const NoColorsMessage();
      case Found:
        final foundState = state as Found;
        return NamesGrid(
          namedColors: foundState.namedColors,
          pageStorageKey: PageStorageKey(runtimeType.toString()),
          onScrolledForwardNearBottom: () => _notifyNextPageNeeded(data),
        );
      default:
        return const BackgroundContainer();
    }
  }

  void _notifyNextPageNeeded(NamesListData data) {
    final isFoundState = data.state is Found;
    if (!isFoundState) {
      return;
    }
    final foundState = data.state as Found;
    data.onSearchChanged(
      foundState.search,
	  currentNamedColors: foundState.namedColors,
      currentPageInfo: foundState.pageInfo,
    );
  }
}
