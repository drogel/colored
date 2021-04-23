import 'package:colored/sources/domain/view_models/colors/color_suggestions/color_suggestions_state.dart';
import 'package:flutter/material.dart';

class ColorSuggestionsData extends InheritedWidget {
  const ColorSuggestionsData({
    required this.state,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final ColorSuggestionsState state;

  static ColorSuggestionsData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: ColorSuggestionsData);

  @override
  bool updateShouldNotify(ColorSuggestionsData oldWidget) =>
      oldWidget.state != state;
}
