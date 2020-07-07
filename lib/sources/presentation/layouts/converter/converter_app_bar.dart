import 'package:colored/sources/presentation/layouts/names_list/color_names_app_bar.dart';
import 'package:colored/sources/presentation/layouts/naming/naming_layout.dart';
import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_animated_switcher.dart';
import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_switcher_state.dart';

import 'package:flutter/material.dart';

class ConverterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ConverterAppBar({
    @required this.searchingState,
    this.onSearchStateChange,
    Key key,
  }) : super(key: key);

  final void Function() onSearchStateChange;
  final CrossSwitcherState searchingState;

  @override
  Widget build(BuildContext context) => CrossAnimatedSwitcher(
        state: searchingState,
        firstChild: NamingLayout(onSearchPressed: onSearchStateChange),
        secondChild: ColorNamesAppBar(onBackPressed: onSearchStateChange),
      );

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
