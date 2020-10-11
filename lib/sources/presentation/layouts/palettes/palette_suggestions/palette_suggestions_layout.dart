import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_state.dart';
import 'package:colored/sources/presentation/layouts/palettes/palette_suggestions/palette_suggestions_list.dart';
import 'package:flutter/material.dart';

class PaletteSuggestionsLayout extends StatelessWidget
    implements PreferredSizeWidget {
  const PaletteSuggestionsLayout({
    this.onSuggestionSelected,
    Key key,
  }) : super(key: key);

  final void Function(String) onSuggestionSelected;

  @override
  Widget build(BuildContext context) {
    final data = PaletteSuggestionsData.of(context);
    switch (data.state.runtimeType) {
      case PaletteSuggestionsFound:
        final suggestions = data.state as PaletteSuggestionsFound;
        return PaletteSuggestionsList(
          suggestions: suggestions.paletteSuggestions,
          onSuggestionSelected: onSuggestionSelected,
        );
      default:
        return Container();
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
