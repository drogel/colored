import 'package:collection/collection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:flutter/material.dart';

class ConverterData extends InheritedWidget {
  const ConverterData({
    @required this.state,
    @required this.clipboardShouldFail,
    @required this.onClipboardRetrieved,
    @required this.onFormatSelection,
    @required this.displayedFormats,
    Widget child,
    Key key,
  })  : assert(state != null),
        super(key: key, child: child);

  final ConverterState state;
  final bool Function(String, Format) clipboardShouldFail;
  final void Function(String, Format) onClipboardRetrieved;
  final void Function(Format, Format) onFormatSelection;
  final List<Format> displayedFormats;

  static ConverterData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ConverterData>();

  @override
  bool updateShouldNotify(ConverterData oldWidget) =>
      state != oldWidget.state ||
      const ListEquality().equals(displayedFormats, oldWidget.displayedFormats);
}
