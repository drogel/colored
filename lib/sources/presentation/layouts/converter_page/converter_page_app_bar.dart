import 'package:colored/sources/domain/view_models/names_list/names_list_data.dart';
import 'package:colored/sources/presentation/layouts/color_suggestions/color_suggestions_layout.dart';
import 'package:colored/sources/presentation/layouts/color_search/color_search_layout.dart';
import 'package:colored/sources/presentation/layouts/naming/naming_layout.dart';
import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_animated_switcher.dart';
import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_switcher_state.dart';

import 'package:flutter/material.dart';

class ConverterPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ConverterPageAppBar({
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
        secondChild: ColorSearchLayout(
          flexibleSpaceChild: ColorSuggestionsLayout(
            onSuggestionSelected: NamesListData.of(context).onSearchChanged,
          ),
          onBackPressed: onSearchStateChange,
        ),
      );

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
