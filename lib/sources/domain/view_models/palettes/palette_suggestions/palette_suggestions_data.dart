import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_state.dart';
import 'package:flutter/material.dart';

class PaletteSuggestionsData extends InheritedWidget {
  const PaletteSuggestionsData({
    required this.state,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final PaletteSuggestionsState state;

  static PaletteSuggestionsData? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType(aspect: PaletteSuggestionsData);

  @override
  bool updateShouldNotify(PaletteSuggestionsData oldWidget) =>
      oldWidget.state != state;
}
