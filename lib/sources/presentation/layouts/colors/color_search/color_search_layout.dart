import 'package:colored/sources/domain/view_models/colors/names_list/names_list_data.dart';
import 'package:colored/sources/presentation/layouts/colors/color_search/color_search_field.dart';
import 'package:colored/sources/presentation/layouts/colors/color_suggestions/color_suggestions_layout.dart';
import 'package:flutter/material.dart';

class ColorSearchLayout extends StatelessWidget implements PreferredSizeWidget {
  const ColorSearchLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        title: const ColorSearchField(),
        centerTitle: true,
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: ColorSuggestionsLayout(
            onSuggestionSelected: NamesListData.of(context)!.onSearchChanged,
          ),
        ),
      );

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
