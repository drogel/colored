import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_state.dart';
import 'package:colored/sources/presentation/layouts/palettes/palettes_list/no_palettes_message.dart';
import 'package:colored/sources/presentation/layouts/palettes/palettes_list/palettes_list_grid.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:colored/sources/presentation/widgets/containers/loading_container.dart';
import 'package:flutter/material.dart';

class PalettesListLayout extends StatelessWidget {
  const PalettesListLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = PalettesListData.of(context)!;
    final state = data.state;
    switch (state.runtimeType) {
      case Starting:
        return const BackgroundContainer();
      case Pending:
        return const LoadingContainer();
      case NoneFound:
        return const NoPalettesMessage();
      case Found:
        final foundState = state as Found;
        return PalettesListGrid(
          pageStorageKey: PageStorageKey(runtimeType.toString()),
          searchString: foundState.search,
          palettes: foundState.palettes,
          onScrolledForwardNearBottom: () => _notifyNextPageNeeded(data),
        );
      default:
        return const BackgroundContainer();
    }
  }

  void _notifyNextPageNeeded(PalettesListData data) {
    final isFoundState = data.state is Found;
    if (!isFoundState) {
      return;
    }
    final foundState = data.state as Found;
    data.onSearchChanged(
      foundState.search,
      currentItems: foundState.palettes,
      currentPageInfo: foundState.pageInfo,
    );
  }
}
