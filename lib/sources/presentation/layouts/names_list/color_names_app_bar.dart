import 'package:colored/sources/presentation/layouts/names_list/color_names_search_field.dart';
import 'package:colored/sources/app/styling/padding.dart' as paddings;
import 'package:flutter/material.dart';

class ColorNamesAppBar extends StatelessWidget {
  const ColorNamesAppBar({this.onBackPressed, Key key}) : super(key: key);

  final void Function() onBackPressed;

  @override
  Widget build(BuildContext context) {
    final actionsTheme = Theme.of(context).appBarTheme.actionsIconTheme;
    return SafeArea(
      child: Padding(
        padding: paddings.button,
        child: ColorNamesSearchField(
          prefixIcon: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(Icons.arrow_back, color: actionsTheme.color),
            onPressed: onBackPressed,
          ),
        ),
      ),
    );
  }
}
