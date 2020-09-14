import 'package:colored/sources/domain/view_models/suggestions/palette_suggestions/palette_suggestions_state.dart';
import 'package:flutter/material.dart';

class PaletteSuggestionsData extends InheritedWidget {
  const PaletteSuggestionsData({
    @required this.state,
    @required Widget child,
    Key key,
  })  : assert(child != null),
        super(key: key, child: child);

  static PaletteSuggestionsData of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType(aspect: PaletteSuggestionsData);

  final PaletteSuggestionsState state;

  @override
  bool updateShouldNotify(PaletteSuggestionsData oldWidget) =>
      oldWidget.state != state;
}
