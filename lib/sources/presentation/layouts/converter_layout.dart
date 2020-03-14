import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/data_models/color_format.dart';
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
            onColorSwipedDown: data.onColorSwipedDown,
            onColorSwipedUp: data.onColorSwipedUp,
            onColorSwipedLeft: data.onColorSwipedLeft,
            onColorSwipedRight: data.onColorSwipedRight,
          ),
          OverlayContainer(
            child: SwipingCrossFade(
              header: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TitledClipboardButton(
                      title: localization.hex,
                      format: ColorFormat.hex,
                      clipboardShouldFail: data.clipboardShouldFail,
                      onClipboardRetrieved: data.onClipboardRetrieved,
                      content: data.state.hexString,
                    ),
                    TitledClipboardButton(
                      title: localization.rgb,
                      format: ColorFormat.rgb,
                      clipboardShouldFail: data.clipboardShouldFail,
                      onClipboardRetrieved: data.onClipboardRetrieved,
                      content: data.state.rgbString,
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
