import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/presentation/widgets/buttons/dropdown_format_button.dart';
import 'package:colored/sources/presentation/widgets/containers/overlay_container.dart';
import 'package:colored/sources/presentation/widgets/containers/swiping_cross_fade.dart';
import 'package:colored/sources/presentation/widgets/sliders/color_sliders.dart';
import 'package:flutter/material.dart';

const _kFormatButtonMinSpace = 160.0;

class ConverterBodyLayout extends StatelessWidget {
  const ConverterBodyLayout({
    this.background,
    this.showSliders = true,
    this.enableGestures = true,
  });

  final Widget background;
  final bool showSliders;
  final bool enableGestures;

  @override
  Widget build(BuildContext context) {
    final data = ConverterData.of(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        if (background != null) background,
        OverlayContainer(
          child: SwipingCrossFade(
            showChild: showSliders,
            enableGestures: enableGestures,
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: LayoutBuilder(
                builder: (_, constraints) => Row(
                  mainAxisAlignment:
                      _computeButtonCount(constraints.maxWidth) == 1
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.spaceBetween,
                  children: _buildFormatButtons(data, constraints.maxWidth),
                ),
              ),
            ),
            child: ColorSliders(
              firstValue: data.state.selection.first,
              secondValue: data.state.selection.second,
              thirdValue: data.state.selection.third,
              onChanged: data.onSelectionChanged,
              onChangeStart: data.onSelectionStart,
              onChangeEnd: data.onSelectionEnd,
              step: data.state.converterStep,
              controller: data.slidersController,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFormatButtons(ConverterData data, double availableWidth) {
    final buttonCount = _computeButtonCount(availableWidth);
    var buttonList = <Widget>[];
    for (var i = 0; i < buttonCount; i += 1) {
      buttonList.add(_buildFormatButton(data, i));
    }
    return buttonList;
  }

  Widget _buildFormatButton(ConverterData data, int index) =>
      DropdownFormatButton(
        title: data.displayedFormats[index].rawValue,
        format: data.displayedFormats[index],
        clipboardShouldFail: data.clipboardShouldFail,
        onClipboardRetrieved: data.onClipboardRetrieved,
        content: data.state.formatData[data.displayedFormats[index]],
        onDropdownSelection: data.onFormatSelection,
      );

  int _computeButtonCount(double availableWidth) {
    final buttonCountSpace = (availableWidth / _kFormatButtonMinSpace).floor();
    final buttonCount = buttonCountSpace.clamp(0, Format.values.length);
    return buttonCount;
  }
}
