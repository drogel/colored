import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/displayed_formats/displayed_formats_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DisplayedFormatsData extends InheritedWidget {
  const DisplayedFormatsData({
    required this.state,
    required this.onFormatSelection,
    required Widget child,
    Key? key,
  })  : assert(child != null),
        super(key: key, child: child);

  final DisplayedFormatsState? state;
  final void Function(Format, Format) onFormatSelection;

  static DisplayedFormatsData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: DisplayedFormatsData);

  @override
  bool updateShouldNotify(DisplayedFormatsData oldWidget) =>
      oldWidget.state != state;
}
