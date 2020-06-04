import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/presentation/widgets/containers/overlay_container.dart';
import 'package:colored/sources/presentation/widgets/containers/swiping_cross_fade.dart';
import 'package:colored/sources/presentation/widgets/sliders/color_sliders.dart';
import 'package:colored/sources/presentation/widgets/buttons/dropdown_format_button.dart';
import 'package:flutter/material.dart';

const _kFormatButtonMinSpace = 140.0;
const _kOverlayContainerMaxHeight = 300.0;

class ConverterBodyLayout extends StatelessWidget {
  const ConverterBodyLayout({
    this.background,
    this.slidersShownIfSpaceAvailable = true,
    this.gesturesEnabledIfSpaceAvailable = true,
  });

  final Widget background;
  final bool slidersShownIfSpaceAvailable;
  final bool gesturesEnabledIfSpaceAvailable;

  @override
  Widget build(BuildContext context) {
    final data = ConverterData.of(context);
    final padding = PaddingData.of(context).paddingScheme;
    final maxButtonCount = Format.values.length;
    final maxContainerWidth = (maxButtonCount + 1.5) * _kFormatButtonMinSpace;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        if (background != null) background,
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContainerWidth),
          child: OverlayContainer(
            child: LayoutBuilder(builder: (_, outerBox) {
              final showSliders = _shouldShowSliders(outerBox.maxHeight);
              final enableGestures = _shouldEnableGestures(outerBox.maxHeight);
              return SwipingCrossFade(
                showChild: showSliders,
                enableGestures: enableGestures,
                header: Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding.base),
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
                  onChangeEnd: data.onSelectionEnd,
                  step: data.state.converterStep,
                  controller: data.slidersController,
                ),
              );
            }),
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

  bool _shouldShowSliders(double availableHeight) {
    if (slidersShownIfSpaceAvailable) {
      final hasAvailableRoom = availableHeight >= _kOverlayContainerMaxHeight;
      return hasAvailableRoom;
    } else {
      return slidersShownIfSpaceAvailable;
    }
  }

  bool _shouldEnableGestures(double availableHeight) {
    if (gesturesEnabledIfSpaceAvailable) {
      final hasAvailableRoom = availableHeight >= _kOverlayContainerMaxHeight;
      return hasAvailableRoom;
    } else {
      return gesturesEnabledIfSpaceAvailable;
    }
  }
}
