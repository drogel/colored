import 'package:collection/collection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:expandable_slider/expandable_slider.dart';
import 'package:flutter/material.dart';

class ConverterData extends InheritedWidget {
  const ConverterData({
    @required this.state,
    @required this.onSelectionChanged,
    @required this.clipboardShouldFail,
    @required this.onClipboardRetrieved,
    @required this.onColorSwipedVertical,
    @required this.onColorSwipedHorizontal,
    @required this.onFormatSelection,
    @required this.displayedFormats,
    this.slidersController,
    Widget child,
    Key key,
  })  : assert(state != null),
        super(key: key, child: child);

  final ConverterState state;
  final void Function(ColorSelection) onSelectionChanged;
  final bool Function(String, Format) clipboardShouldFail;
  final void Function(String, Format) onClipboardRetrieved;
  final void Function(double) onColorSwipedVertical;
  final void Function(double) onColorSwipedHorizontal;
  final void Function(Format, Format) onFormatSelection;
  final List<Format> displayedFormats;
  final ExpandableSliderController slidersController;

  static ConverterData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ConverterData>();

  @override
  bool updateShouldNotify(ConverterData oldWidget) =>
      state != oldWidget.state ||
      const ListEquality().equals(displayedFormats, oldWidget.displayedFormats);
}
