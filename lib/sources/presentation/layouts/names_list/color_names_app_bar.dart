import 'package:colored/sources/domain/view_models/names_list/names_list_data.dart';
import 'package:colored/sources/presentation/layouts/names_list/color_names_search_field.dart';
import 'file:///D:/Programas/Flutter/colored/colored/lib/sources/app/styling/padding/padding_constants.dart' as paddings;
import 'package:flutter/material.dart';

class ColorNamesAppBar extends StatelessWidget {
  const ColorNamesAppBar({this.onBackPressed, Key key}) : super(key: key);

  final void Function() onBackPressed;

  @override
  Widget build(BuildContext context) {
    final actionsTheme = Theme.of(context).appBarTheme.actionsIconTheme;
    final data = NamesListData.of(context);
    return SafeArea(
      child: Padding(
        padding: paddings.medium,
        child: ColorNamesSearchField(
          prefixIcon: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(Icons.arrow_back, color: actionsTheme.color),
            onPressed: () => _onBackPressed(data),
          ),
        ),
      ),
    );
  }

  void _onBackPressed(NamesListData data) {
    data.onBackPressed();
    onBackPressed();
  }
}
