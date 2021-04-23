import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:flutter/material.dart';

class PaletteDetailData extends InheritedWidget {
  const PaletteDetailData({
    required this.state,
    required this.onPaletteSelected,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final PaletteDetailState state;
  final void Function(List<String>, String) onPaletteSelected;

  static PaletteDetailData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: PaletteDetailData);

  @override
  bool updateShouldNotify(PaletteDetailData oldWidget) =>
      oldWidget.state != state;
}
