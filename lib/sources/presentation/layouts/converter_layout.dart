import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/presentation/widgets/buttons/titled_clipboard_button.dart';
import 'package:colored/sources/presentation/widgets/containers/overlay_container.dart';
import 'package:colored/sources/presentation/widgets/containers/swiping_color_container.dart';
import 'package:colored/sources/presentation/widgets/containers/swiping_cross_fade.dart';
import 'package:colored/sources/presentation/widgets/sliders/color_sliders.dart';
import 'package:flutter/material.dart';

class ConverterLayout extends StatelessWidget {
  const ConverterLayout();

  @override
  Widget build(BuildContext context) {
    final data = ConverterData.of(context);
    final localization = Localization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.colorConverter),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          SwipingColorContainer(
            color: data.state.color,
            onColorSwipedVertical: data.onColorSwipedVertical,
            onColorSwipedHorizontal: data.onColorSwipedHorizontal,
          ),
          OverlayContainer(
            child: SwipingCrossFade(
              header: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DropdownFormatButton(
                      title: data.displayedFormats[0].rawValue,
                      format: data.displayedFormats[0],
                      clipboardShouldFail: data.clipboardShouldFail,
                      onClipboardRetrieved: data.onClipboardRetrieved,
                      content: data.state.formatData[data.displayedFormats[0]],
                      onDropdownSelection: data.onFormatSelection,
                    ),
                    DropdownFormatButton(
                      title: data.displayedFormats[1].rawValue,
                      format: data.displayedFormats[1],
                      clipboardShouldFail: data.clipboardShouldFail,
                      onClipboardRetrieved: data.onClipboardRetrieved,
                      content: data.state.formatData[data.displayedFormats[1]],
                      onDropdownSelection: data.onFormatSelection,
                    ),
                  ],
                ),
              ),
              child: ColorSliders(
                firstValue: data.state.selection.first,
                secondValue: data.state.selection.second,
                thirdValue: data.state.selection.third,
                onChanged: data.onSelectionChanged,
                step: data.state.converterStep,
                controller: data.slidersController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
