import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_data.dart';
import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_state.dart';
import 'package:colored/sources/presentation/layouts/color_suggestions/color_suggestions_list.dart';
import 'package:flutter/material.dart';

class ColorSuggestionsLayout extends StatelessWidget
    implements PreferredSizeWidget {
  const ColorSuggestionsLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ColorSuggestionsData.of(context);
    switch (data.state.runtimeType) {
      case SuggestionsFound:
        return _buildSuggestionsWidget(data);
      default:
        return _buildDefaultWidget();
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);

  Widget _buildSuggestionsWidget(ColorSuggestionsData data) {
    final suggestionsState = data.state as SuggestionsFound;
    return ColorSuggestionsList(suggestions: suggestionsState.colorSuggestions);
  }

  Widget _buildDefaultWidget() => Container();
}
