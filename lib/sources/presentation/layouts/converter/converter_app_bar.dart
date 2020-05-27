import 'package:colored/sources/app/styling/durations.dart' as durations;
import 'package:colored/sources/app/styling/curves.dart' as curves;
import 'package:colored/sources/presentation/layouts/names_list/color_names_app_bar.dart';
import 'package:colored/sources/presentation/layouts/naming/naming_app_bar.dart';

import 'package:flutter/material.dart';

class ConverterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ConverterAppBar({
    @required this.isSearching,
    this.onSearchStateChange,
    Key key,
  }) : super(key: key);

  final void Function() onSearchStateChange;
  final bool isSearching;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: durations.mediumPresenting,
        switchInCurve: curves.incoming,
        child: isSearching
            ? ColorNamesAppBar(onBackPressed: onSearchStateChange)
            : NamingAppBar(onSearchPressed: onSearchStateChange),
      );

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}