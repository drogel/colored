import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_data.dart';
import 'package:colored/sources/presentation/widgets/buttons/dropdown_format_button.dart';
import 'package:flutter/material.dart';

class DisplayedFormatsLayout extends StatelessWidget {
  const DisplayedFormatsLayout({
    @required this.buttonMinSpace,
    @required this.converterData,
    Key key,
  }) : super(key: key);

  final double buttonMinSpace;
  final ConverterData converterData;

  @override
  Widget build(BuildContext context) {
    final data = DisplayedFormatsData.of(context);
    return LayoutBuilder(
      builder: (_, constraints) {
        final availableWidth = constraints.maxWidth;
        return Row(
          mainAxisAlignment: _computeButtonCount(availableWidth) == 1
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.spaceBetween,
          children: _buildFormatButtons(data, availableWidth),
        );
      },
    );
  }

  List<Widget> _buildFormatButtons(
    DisplayedFormatsData data,
    double availableWidth,
  ) {
    final buttonCount = _computeButtonCount(availableWidth);
    var buttonList = <Widget>[];

    for (var i = 0; i < buttonCount; i += 1) {
      buttonList.add(_buildFormatButton(data, i));
    }

    return buttonList;
  }

  Widget _buildFormatButton(DisplayedFormatsData data, int index) {
    final displayedFormats = data.state.formats;
    return DropdownFormatButton(
      title: displayedFormats[index].rawValue,
      format: displayedFormats[index],
      clipboardShouldFail: converterData.clipboardShouldFail,
      onClipboardRetrieved: converterData.onClipboardRetrieved,
      content: converterData.state.formatData[displayedFormats[index]],
      onDropdownSelection: data.onFormatSelection,
    );
  }

  int _computeButtonCount(double availableWidth) {
    final buttonCountSpace = (availableWidth / buttonMinSpace).floor();
    final buttonCount = buttonCountSpace.clamp(0, Format.values.length);
    return buttonCount;
  }
}
