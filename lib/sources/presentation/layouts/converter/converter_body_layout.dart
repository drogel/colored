import 'package:colored/sources/app/styling/padding/padding_scheme.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hsl/hsl_picker.dart';
import 'package:colored/sources/presentation/widgets/containers/overlay_container.dart';
import 'package:colored/sources/presentation/widgets/containers/swiping_cross_fade.dart';
import 'package:colored/sources/presentation/widgets/buttons/dropdown_format_button.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hsv/hsv_picker.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hue/hue_picker.dart';
import 'package:flutter/material.dart';

const _kFormatButtonMinSpace = 140.0;
const _kOverlayContainerMaxHeight = 300.0;

class ConverterBodyLayout extends StatelessWidget {
  const ConverterBodyLayout({
    this.background,
    this.slidersShownIfSpaceAvailable = true,
  });

  final Widget background;
  final bool slidersShownIfSpaceAvailable;

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
            child: LayoutBuilder(
              builder: (_, outerBox) {
                final showChild = _shouldShowOverlayChild(outerBox.maxHeight);
                return SwipingCrossFade(
                  showChild: showChild,
                  enableGestures: false,
                  header: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding.base),
                    child: LayoutBuilder(
                      builder: (_, constraints) => Row(
                        mainAxisAlignment:
                            _computeButtonCount(constraints.maxWidth) == 1
                                ? MainAxisAlignment.spaceAround
                                : MainAxisAlignment.spaceBetween,
                        children:
                            _buildFormatButtons(data, constraints.maxWidth),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: _getInnerPadding(padding),
                    child: Column(
                      children: [
                        HuePicker(
                          color: data.state.color,
                          onChangeEnd: data.onSelectionEnd,
                          onChanged: data.onSelectionChanged,
                          onChangeStart: data.onSelectionStarted,
                        ),
                        HslPicker(
                          color: data.state.color,
                          onChangeEnd: data.onSelectionEnd,
                          onChanged: data.onSelectionChanged,
                          onChangeStart: data.onSelectionStarted,
                        )
                      ],
                    ),
                  ),
                );
              },
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

  bool _shouldShowOverlayChild(double availableHeight) {
    if (slidersShownIfSpaceAvailable) {
      final hasAvailableRoom = availableHeight >= _kOverlayContainerMaxHeight;
      return hasAvailableRoom;
    } else {
      return slidersShownIfSpaceAvailable;
    }
  }

  EdgeInsets _getInnerPadding(PaddingScheme padding) {
    final defaultPaddingValue = padding.large.bottom + padding.small.top;
    return EdgeInsets.only(bottom: defaultPaddingValue, top: padding.small.top);
  }
}
