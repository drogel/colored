import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:flutter/material.dart';

class PaletteDetailData extends InheritedWidget {
  const PaletteDetailData({
    @required this.state,
    @required Widget child,
    Key key,
  })  : assert(child != null),
        assert(state != null),
        super(key: key, child: child);

  static PaletteDetailData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: PaletteDetailData);

  final PaletteDetailState state;

  @override
  bool updateShouldNotify(PaletteDetailData oldWidget) =>
      oldWidget.state != state;
}
