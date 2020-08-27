import 'package:colored/sources/domain/view_models/lists/palettes_list/palettes_list_data.dart';
import 'package:colored/sources/presentation/layouts/search/palette_search/palette_search_field.dart';
import 'package:colored/sources/presentation/layouts/suggestions/palette_suggestions/palette_suggestions_layout.dart';
import 'package:flutter/material.dart';

class PaletteSearchLayout extends StatelessWidget
    implements PreferredSizeWidget {
  const PaletteSearchLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        title: const PaletteSearchField(),
        centerTitle: true,
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: PaletteSuggestionsLayout(
            onSuggestionSelected: PalettesListData.of(context).onSearchChanged,
          ),
        ),
      );

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
