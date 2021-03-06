import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_data.dart';
import 'package:colored/sources/domain/view_models/converter/displayed_formats/displayed_formats_data.dart';
import 'package:colored/sources/presentation/widgets/buttons/dropdown_format_button.dart';
import 'package:colored/sources/presentation/widgets/layouts/dynamic_row.dart';
import 'package:flutter/material.dart';

class DisplayedFormatsLayout extends StatelessWidget {
  const DisplayedFormatsLayout({
    required this.buttonMinSpace,
    required this.converterData,
    Key? key,
  }) : super(key: key);

  final double buttonMinSpace;
  final ConverterData converterData;

  @override
  Widget build(BuildContext context) {
    final data = DisplayedFormatsData.of(context)!;
    return LayoutBuilder(
      builder: (_, constraints) {
        final availableWidth = constraints.maxWidth;
        final count = _computeButtonCount(availableWidth);
        return DynamicRow(
          itemCount: count,
          mainAxisAlignment: _getButtonAlignment(count),
          itemBuilder: (_, index) => _buildFormatButton(data, index),
        );
      },
    );
  }

  Widget _buildFormatButton(DisplayedFormatsData data, int index) {
    final displayedFormats = data.state.formats;
    final content = converterData.state.formatData[displayedFormats[index]];
    if (content == null) {
      throw ArgumentError("Format not contained in state formatData map");
    }
    return DropdownFormatButton(
      title: displayedFormats[index].rawValue,
      format: displayedFormats[index],
      clipboardShouldFail: converterData.clipboardShouldFail,
      onClipboardRetrieved: converterData.onClipboardRetrieved,
      content: content,
      onDropdownSelection: data.onFormatSelection,
    );
  }

  int _computeButtonCount(double availableWidth) {
    final buttonCountSpace = (availableWidth / buttonMinSpace).floor();
    final num buttonCount = buttonCountSpace.clamp(0, Format.values.length);
    return buttonCount as int;
  }

  MainAxisAlignment _getButtonAlignment(int buttonCount) => buttonCount == 1
      ? MainAxisAlignment.spaceAround
      : MainAxisAlignment.spaceBetween;
}
