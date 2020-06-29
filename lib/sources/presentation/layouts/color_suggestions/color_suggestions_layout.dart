import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_data.dart';
import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_state.dart';
import 'package:colored/sources/presentation/layouts/color_suggestions/color_suggestions_list.dart';
import 'package:flutter/material.dart';

class ColorSuggestionsLayout extends StatelessWidget
    implements PreferredSizeWidget {
  const ColorSuggestionsLayout({
    this.onSuggestionSelected,
    Key key,
  }) : super(key: key);

  final void Function(String) onSuggestionSelected;

  @override
  Widget build(BuildContext context) {
    final data = ColorSuggestionsData.of(context);
    switch (data.state.runtimeType) {
      case ColorSuggestionsFound:
        return _buildSuggestionsWidget(data.state as ColorSuggestionsFound);
      default:
        return _buildDefaultWidget();
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);

  Widget _buildSuggestionsWidget(ColorSuggestionsFound suggestions) =>
      ColorSuggestionsList(
        suggestions: suggestions.colorSuggestions,
        onSuggestionSelected: onSuggestionSelected,
      );

  Widget _buildDefaultWidget() => Container();
}
